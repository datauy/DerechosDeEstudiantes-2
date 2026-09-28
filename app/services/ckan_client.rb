require 'json'
require 'net/http'
require 'securerandom'
require 'uri'

class CkanClient
  class Error < StandardError
    attr_reader :status, :body

    def initialize(message, status: nil, body: nil)
      super(message)
      @status = status
      @body = body
    end
  end

  def initialize(server:, api_key:, open_timeout: 10, read_timeout: 60)
    raise ArgumentError, 'CKAN server is required' if server.to_s.empty?
    raise ArgumentError, 'CKAN API key is required' if api_key.to_s.empty?

    @server = server.to_s.sub(%r{/+$}, '')
    @api_key = api_key
    @open_timeout = open_timeout
    @read_timeout = read_timeout
  end

  def package_show(id:)
    action('package_show', { id: id })
  rescue Error => error
    return nil if error.message.match?(/not found/i)

    raise
  end

  def package_create(data)
    action('package_create', data)
  end

  def resource_create(data, upload: nil)
    action('resource_create', data, upload: upload)
  end

  def resource_update(data, upload: nil)
    action('resource_update', data, upload: upload)
  end

  private

  def action(name, data, upload: nil)
    uri = URI.parse("#{@server}/api/3/action/#{name}")
    request = Net::HTTP::Post.new(uri.request_uri)
    request['Authorization'] = @api_key
    if upload
      request['Content-Type'], request.body = multipart_body(data, upload)
    else
      request['Content-Type'] = 'application/json'
      request.body = JSON.generate(data)
    end
    response = perform(uri, request)
    parse_response(name, response)
  end

  def multipart_body(data, upload)
    boundary = "----DerechosDeEstudiantes#{SecureRandom.hex(12)}"
    body = data.each_with_object(+'') do |(name, value), result|
      result << "--#{boundary}\r\n"
      result << "Content-Disposition: form-data; name=\"#{name}\"\r\n\r\n"
      result << "#{value}\r\n"
    end
    body << "--#{boundary}\r\n"
    body << "Content-Disposition: form-data; name=\"upload\"; filename=\"#{File.basename(upload)}\"\r\n"
    content_type = File.extname(upload).downcase == '.csv' ? 'text/csv' : 'application/json'
    body << "Content-Type: #{content_type}\r\n\r\n"
    body << File.binread(upload)
    body << "\r\n--#{boundary}--\r\n"
    ["multipart/form-data; boundary=#{boundary}", body]
  end

  def perform(uri, request)
    Net::HTTP.start(
      uri.host,
      uri.port,
      use_ssl: uri.scheme == 'https',
      open_timeout: @open_timeout,
      read_timeout: @read_timeout
    ) { |http| http.request(request) }
  rescue Timeout::Error, SocketError, SystemCallError => error
    raise Error, "CKAN request failed: #{error.message}"
  end

  def parse_response(action_name, response)
    body = JSON.parse(response.body)
    unless response.code.to_i.between?(200, 299) && body['success']
      error = body['error'] || body['result'] || response.body
      raise Error.new("CKAN #{action_name} failed: #{error}", status: response.code, body: body)
    end

    body['result']
  rescue JSON::ParserError => error
    raise Error.new("CKAN #{action_name} returned invalid JSON: #{error.message}", status: response.code, body: response.body)
  end
end
