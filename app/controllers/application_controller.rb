class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :get_establecimientos
  def get_establecimientos(name)
    require 'open-uri'
    url = "https://ee-backend.development.datauy.org/api/busca-establecimientos?nombre=arti&subsis=#{name}"
    return JSON.load(open(url))
  end

end
