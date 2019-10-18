class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  require "json"


  def get_json_response(url)
    require 'open-uri'
    return JSON.load(open(url))
  end

  helper_method :get_institutions_json
  def get_institutions_json
    json_institutions = get_json_response(
      "https://ee-backend.development.datauy.org/api/busca-establecimientos?subsis=#{session[:search_type]}"
    )
    @array_institutions = json_institutions['establecimientos'].map { |e| e['nombre'] }.join(',')
  end

  helper_method :get_locations_json
  def get_locations_json
    file = File.open "#{Rails.root}/public/ubicaciones.json"
    json_locations = JSON.load file
    @array_locations = json_locations.map { |e| e['nombre'].sub ',', ' -' }.join(',')
  end
end
