require 'fileutils'
require 'csv'
require 'date'
require 'json'
require 'pathname'

class ReportExporter
  Dataset = Struct.new(:name, :headers, :data, keyword_init: true)

  def initialize(output_root: Rails.root.join('public', 'data'), export_date: Date.today - 1)
    @output_root = Pathname.new(output_root)
    @export_date = export_date
  end

  def export
    dated_directory = @output_root.join(@export_date.strftime('%Y-%m'))
    latest_directory = @output_root.join('latest')
    FileUtils.mkdir_p(dated_directory)
    FileUtils.mkdir_p(latest_directory)

    datasets.each_with_object({}) do |dataset, paths|
      paths[dataset.name] = write_dataset(dataset, dated_directory, latest_directory)
    end
  end

  def datasets
    [
      Dataset.new(name: 'preguntas', headers: questions_headers, data: questions_data),
      Dataset.new(name: 'respuestas', headers: answers_headers, data: answers_data),
      Dataset.new(name: 'dudas', headers: doubts_headers, data: doubts_data),
      Dataset.new(name: 'derechos', headers: rights_headers, data: rights_data)
    ]
  end

  private

  def write_dataset(dataset, dated_directory, latest_directory)
    dated_json = dated_directory.join("#{dataset.name}.json")
    dated_csv = dated_directory.join("#{dataset.name}.csv")
    latest_json = latest_directory.join("#{dataset.name}.json")
    latest_csv = latest_directory.join("#{dataset.name}.csv")

    write_json(dataset.data, dated_json)
    write_csv(dataset.data, dataset.headers, dated_csv)
    write_json(dataset.data, latest_json)
    write_csv(dataset.data, dataset.headers, latest_csv)

    { json: latest_json, csv: latest_csv, dated_json: dated_json, dated_csv: dated_csv }
  end

  def write_json(data, path)
    File.write(path, data.to_json)
  end

  def write_csv(data, headers, path)
    CSV.open(path, 'wb') do |csv|
      csv << headers.split(', ')
      data.each { |object| csv << object.attributes.values }
    end
  end

  def questions_headers
    'id, location, institution, grade, created_at, message, subsistema, count_help'
  end

  def questions_data
    Question.where(is_public: true).select(questions_headers.sub('subsistema', 'collage')).order(:id)
  end

  def answers_headers
    'id, message, question_id, is_user, created_at'
  end

  def answers_data
    Answer.where(is_public: true).select(answers_headers).order(:id)
  end

  def doubts_headers
    'id, message, right_id, created_at'
  end

  def doubts_data
    Doubt.select(doubts_headers).order(:id)
  end

  def rights_headers
    'id, title, created_at, school_type, description, tag_one, tag_two, tag_three, tag_four, count_help'
  end

  def rights_data
    Right.select(rights_headers).order(:id)
  end
end
