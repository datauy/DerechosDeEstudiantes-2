class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_cache
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
      file = File.open "#{Rails.root}/public/ubicaciones.json"
      json_locations = JSON.load file
      @array_locations = json_locations.map { |e| e['nombre'].sub ',', ' -' }.join(',')
  end

  def set_cache
    expires_in 3.minutes, :public => true
  end

  def access_denied(exception)
    redirect_to admin_root_path, alert: exception.message
  end
end
