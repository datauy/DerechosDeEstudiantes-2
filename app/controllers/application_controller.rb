class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def get_establecimientos(name)
    require 'open-uri'
    url = "https://ee-backend.development.datauy.org/api/busca-establecimientos?nombre=arti&subsis=#{name}"
    return JSON.load(open(url))
  end

  helper_method :get_establecimientos_json
  def get_establecimientos_json
    @json_establecimientos = get_establecimientos(session[:search_type])
  end

end
