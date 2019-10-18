class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  require "json"


  def get_json_response(url)
    require 'open-uri'
    return JSON.load(open(url))
  end

  helper_method :get_institutions_json
  def get_institutions_json
    if session[:search_type]
      file = File.open "#{Rails.root}/public/#{session[:search_type]}.json"
      json_institutions = JSON.load file
      @array_institutions = json_institutions['establecimientos'].map { |e| e['nombre'] }.join(',')
    else
      @array_institutions = {}
    end
  end

  helper_method :get_locations_json
  def get_locations_json
    if session[:search_type]
      file = File.open "#{Rails.root}/public/ubicaciones.json"
      json_locations = JSON.load file
      @array_locations = json_locations.map { |e| e['nombre'].sub ',', ' -' }.join(',')
    else
      @array_locations = {}
    end
  end
end
