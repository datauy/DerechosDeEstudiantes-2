class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def get_json_response(url)
    require 'open-uri'
    return JSON.load(open(url))
  end

  helper_method :get_institutions_json
  def get_institutions_json
    json_institutions = get_json_response(
      "https://ee-backend.development.datauy.org/api/busca-establecimientos?nombre=arti&subsis=#{session[:search_type]}"
    )
    @array_institutions = json_institutions['establecimientos'].map { |e| e['nombre'] }.join(',')
  end

  helper_method :get_locations_json
  def get_locations_json
    json_locations = get_json_response(
      "https://ee-backend.development.datauy.org/api/ubicaciones"
    )
    @array_locations= json_locations.map { |e| e['nombre'] }.join(',')
  end
end
