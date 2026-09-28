
namespace :dataexport do
  desc 'Exports all database objects and relations'
  task all: :environment do
    ReportExporter.new.export
    puts 'Exportación de datos completada'
  end

  desc 'Exports reports and synchronizes them with CKAN'
  task ckan_upload: :environment do
    exported_files = ReportExporter.new.export
    CkanReportPublisher.new.publish(exported_files: exported_files)
    puts 'Publicación en CKAN completada'
  end
end
