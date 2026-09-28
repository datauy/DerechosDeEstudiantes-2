class CkanReportPublisher
  DEFAULT_PACKAGE_NAME = 'derechos-de-estudiantes'
  RESOURCE_NAMES = %w[preguntas respuestas dudas derechos].freeze

  def initialize(client: nil, credentials: Rails.application.credentials[:ckan], public_base_url: nil)
    @credentials = credentials || {}
    raise ArgumentError, 'CKAN organization is required' if @credentials[:organization].to_s.empty?

    @client = client || CkanClient.new(
      server: @credentials[:server],
      api_key: @credentials[:api_key]
    )
    @public_base_url = (public_base_url || @credentials[:public_base_url] || default_public_base_url).sub(%r{/+$}, '')
  end

  def publish(exported_files: ReportExporter.new.export)
    package = @client.package_show(id: package_name)
    package ||= @client.package_create(package_attributes)

    exported_files.each do |name, paths|
      next unless RESOURCE_NAMES.include?(name.to_s)

      synchronize_resource(package, name.to_s, paths[:json], 'JSON', "#{name}.json")
      synchronize_resource(package, name.to_s, paths[:csv], 'CSV', "#{name}.csv")
    end

    package
  end

  private

  def package_name
    @credentials[:package_name].presence || DEFAULT_PACKAGE_NAME
  end

  def package_attributes
    {
      name: package_name,
      title: @credentials[:title].presence || 'Derechos de Estudiantes',
      notes: @credentials[:notes].presence || 'Datos públicos de la plataforma Derechos de Estudiantes.',
      owner_org: @credentials[:organization]
    }.compact
  end

  def synchronize_resource(package, name, path, format, filename)
    return unless path

    mimetype = format == 'CSV' ? 'text/csv' : 'application/json'
    resource = package.fetch('resources', []).find do |item|
      item['name'] == name && item['format'].to_s.casecmp(format).zero?
    end
    attributes = {
      name: name,
      package_id: package['id'],
      url: "#{@public_base_url}/data/latest/#{filename}",
      format: format,
      mimetype: mimetype,
      last_modified: File.mtime(path).utc.iso8601
    }

    if resource
      @client.resource_update(attributes.merge(id: resource['id']), upload: path)
    else
      @client.resource_create(attributes, upload: path)
    end
  end

  def default_public_base_url
    host = Rails.application.routes.default_url_options[:host].to_s
    host.start_with?('http://', 'https://') ? host : "https://#{host}"
  end
end
