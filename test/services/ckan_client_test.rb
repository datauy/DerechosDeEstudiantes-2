require 'test_helper'
require 'json'
require 'net/http'
require 'tempfile'

class CkanClientTest < ActiveSupport::TestCase
  def setup_fixtures
  end

  def teardown_fixtures
  end

  class StubbedClient < CkanClient
    attr_reader :requests

    def initialize(response)
      super(server: 'https://catalog.example.test', api_key: 'token')
      @response = response
      @requests = []
    end

    private

    def perform(uri, request)
      @requests << [uri, request]
      @response
    end
  end

  test 'posts versioned action requests with authorization and returns the result' do
    response = Struct.new(:code, :body).new('200', JSON.generate('success' => true, 'result' => { 'id' => 'package-id' }))
    client = StubbedClient.new(response)

    result = client.package_create(name: 'derechos-de-estudiantes')
    uri, request = client.requests.first

    assert_equal({ 'id' => 'package-id' }, result)
    assert_equal '/api/3/action/package_create', uri.request_uri
    assert_equal 'token', request['Authorization']
    assert_equal({ 'name' => 'derechos-de-estudiantes' }, JSON.parse(request.body))
  end

  test 'raises when CKAN reports an unsuccessful action' do
    response = Struct.new(:code, :body).new('401', JSON.generate('success' => false, 'error' => { 'message' => 'Access denied' }))
    client = StubbedClient.new(response)

    error = assert_raises(CkanClient::Error) { client.package_show(id: 'private-package') }

    assert_match(/Access denied/, error.message)
    assert_equal '401', error.status
  end

  test 'uploads a resource as multipart form data' do
    response = Struct.new(:code, :body).new('200', JSON.generate('success' => true, 'result' => { 'id' => 'resource-id' }))
    client = StubbedClient.new(response)
    file = Tempfile.new(['preguntas', '.json'])
    file.write('[]')
    file.close

    client.resource_create({ package_id: 'package-id', name: 'preguntas' }, upload: file.path)
    _uri, request = client.requests.first

    assert_match(%r{multipart/form-data; boundary=}, request['Content-Type'])
    assert_match(/name="upload"; filename="preguntas/, request.body)
    assert_match(/\r\n\[\]\r\n/, request.body)
  ensure
    file.unlink if file
  end
  test 'uses the CSV MIME type for CSV uploads' do
    response = Struct.new(:code, :body).new('200', JSON.generate('success' => true, 'result' => { 'id' => 'resource-id' }))
    client = StubbedClient.new(response)
    file = Tempfile.new(['preguntas', '.csv'])
    file.write("id,message\n1,test\n")
    file.close

    client.resource_create({ package_id: 'package-id', name: 'preguntas-csv' }, upload: file.path)
    _uri, request = client.requests.first

    assert_match(/Content-Type: text\/csv/, request.body)
    assert_includes request.body, "\r\nid,message\n1,test\n\r\n"
  ensure
    file.unlink if file
  end
end
