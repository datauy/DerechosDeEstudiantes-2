
namespace :dataexport do
  desc 'Exports all database objects and relations '
  task :all => :environment do
		require 'json'
		require 'csv'
		require 'date'
		dir = "#{Rails.root}/public/data/#{( Date.today - 1 ).strftime('%Y-%m')}/"
		system 'mkdir', '-p', dir
		#Preguntas
    puts "- exporting questions into #{dir}"
    write_to_disk(questions_data, questions_headers, dir, 'preguntas')
		write_to_disk(answers_data, answers_headers, dir, 'respuestas')
		write_to_disk(doubts_data, doubts_headers, dir, 'dudas')
		write_to_disk(rights_data, rights_headers, dir, 'derechos')
  end
end

#00 00 01 * * /bin/bash -c 'export PATH="/home/datauy/.rbenv/bin:$PATH" ; eval "$(rbenv init -)"; cd /home/datauy/quesabes-data; ruby ./data.rb'
def questions_headers
	'id, location, institution, grade, created_at, message, subsistema, count_help'
end
def questions_data
	questions_columns = questions_headers.sub 'subsistema','collage'
	Question.
	where(is_public: true).
	select( questions_columns ).
	order(:id)
end
def answers_headers
	'id, message, question_id, is_user, created_at'
end
def answers_data
	Answer.
	where(is_public: true).
	select( answers_headers ).
	order(:id)
end
def doubts_headers
	'id, message, right_id, created_at'
end
def doubts_data
	Doubt.
	#where(is_public: true).
	select( doubts_headers ).
	order(:id)
end
def rights_headers
	'id, title, created_at, school_type, description, tag_one, tag_two, tag_three, tag_four, count_help'
end
def rights_data
	Right.
	select( rights_headers ).
	order(:id)
end

def write_to_disk(data, headers, output_path, filename)
	write_to_json(data, output_path + filename + '.json')
	write_csv(data, headers, output_path + filename + '.csv')
	write_to_json(data, 'public/data/latest/' + filename + '.json')
  write_csv(data, headers, 'public/data/latest/' + filename + '.csv')
end

def write_csv(data, headers, output_path)
	CSV.open(output_path, "wb") do |csv|
		csv << headers.split(', ')
		data.each do |obj|
		  csv << obj.attributes.values
  	    end
	end
	print "Escribio los datos en csv a %s\n" % output_path
end

def write_to_json(data, output_path)
	File.open(output_path, 'w') do |f|
		f.write(data.to_json)
	end
	print "Escribio los datos en json a %s\n" % output_path
end
