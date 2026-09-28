require 'test_helper'
require 'tmpdir'

class CkanReportPublisherTest < ActiveSupport::TestCase
  def setup_fixtures
  end

  def teardown_fixtures
  end

  class FakeClient
    attr_reader :created_resources, :updated_resources

    def initialize(package: nil)
      @package = package
      @created_resources = []
      @updated_resources = []
    end

    def package_show(id:)
      @package
    end

    def package_create(attributes)
      @package = attributes.stringify_keys.merge('id' => 'package-id', 'resources' => [])
    end

    def resource_create(attributes, upload: nil)
      resource = attributes.stringify_keys.merge('id' => "resource-#{@created_resources.length + 1}")
      @created_resources << resource
      @package['resources'] << resource
      resource
    end

    def resource_update(attributes, upload: nil)
      @updated_resources << attributes
      attributes
    end
  end

  test 'creates JSON and CSV resources and updates them on the next run' do
    Dir.mktmpdir do |directory|
      exported_files = %w[preguntas respuestas dudas derechos].each_with_object({}) do |name, files|
        json_path = File.join(directory, "#{name}.json")
        csv_path = File.join(directory, "#{name}.csv")
        File.write(json_path, '[]')
        File.write(csv_path, "id,message\n1,test\n")
        files[name] = { json: json_path, csv: csv_path }
      end
      client = FakeClient.new
      publisher = CkanReportPublisher.new(
        client: client,
        credentials: { organization: 'datauy' },
        public_base_url: 'https://derechosdeestudiantes.edu.uy'
      )

      publisher.publish(exported_files: exported_files)
      publisher.publish(exported_files: exported_files)

      assert_equal %w[preguntas preguntas respuestas respuestas dudas dudas derechos derechos], client.created_resources.map { |resource| resource['name'] }
      assert_equal 8, client.updated_resources.length
      assert_equal %w[preguntas preguntas respuestas respuestas dudas dudas derechos derechos], client.updated_resources.map { |resource| resource[:name] }
      assert_equal 'https://derechosdeestudiantes.edu.uy/data/latest/preguntas.json', client.updated_resources.first[:url]
      assert_equal 'https://derechosdeestudiantes.edu.uy/data/latest/preguntas.csv', client.updated_resources.second[:url]
      assert_equal 'CSV', client.updated_resources.second[:format]
      assert_equal 'text/csv', client.updated_resources.second[:mimetype]
    end
  end

  test 'does not require an organization when publishing can proceed without one' do
    publisher = CkanReportPublisher.new(client: FakeClient.new, credentials: {})

    assert_instance_of CkanReportPublisher, publisher
  end
end
