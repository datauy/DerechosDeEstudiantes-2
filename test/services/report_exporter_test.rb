require 'test_helper'
require 'csv'
require 'json'
require 'tmpdir'

class ReportExporterTest < ActiveSupport::TestCase
  def setup_fixtures
  end

  def teardown_fixtures
  end

  FakeRecord = Struct.new(:attributes) do
    def as_json(*)
      attributes
    end
  end

  class StubbedReportExporter < ReportExporter
    def initialize(datasets, **options)
      @stubbed_datasets = datasets
      super(**options)
    end

    def datasets
      @stubbed_datasets
    end
  end

  test 'creates dated and latest JSON and CSV files for every dataset' do
    datasets = [
      ReportExporter::Dataset.new(
        name: 'preguntas',
        headers: 'id, message',
        data: [FakeRecord.new('id' => 1, 'message' => 'Pregunta')]
      ),
      ReportExporter::Dataset.new(
        name: 'respuestas',
        headers: 'id, question_id, message',
        data: [FakeRecord.new('id' => 2, 'question_id' => 1, 'message' => 'Respuesta')]
      ),
      ReportExporter::Dataset.new(
        name: 'dudas',
        headers: 'id, right_id, message',
        data: [FakeRecord.new('id' => 3, 'right_id' => 4, 'message' => 'Duda')]
      ),
      ReportExporter::Dataset.new(
        name: 'derechos',
        headers: 'id, title',
        data: [FakeRecord.new('id' => 4, 'title' => 'Derecho')]
      )
    ]

    Dir.mktmpdir do |directory|
      exported_files = StubbedReportExporter.new(
        datasets,
        output_root: directory,
        export_date: Date.new(2024, 2, 3)
      ).export

      datasets.each do |dataset|
        paths = exported_files.fetch(dataset.name)
        expected_json = dataset.data.map(&:attributes)
        expected_csv = [dataset.headers.split(', ')] + dataset.data.map do |record|
          record.attributes.values.map(&:to_s)
        end

        assert_equal expected_json, JSON.parse(File.read(paths[:dated_json]))
        assert_equal expected_json, JSON.parse(File.read(paths[:json]))
        assert_equal expected_csv, CSV.read(paths[:dated_csv])
        assert_equal expected_csv, CSV.read(paths[:csv])
        assert_equal File.join(directory, '2024-02', "#{dataset.name}.json"), paths[:dated_json].to_s
        assert_equal File.join(directory, 'latest', "#{dataset.name}.json"), paths[:json].to_s
      end
    end
  end
end
