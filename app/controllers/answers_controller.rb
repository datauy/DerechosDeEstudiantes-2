class AnswersController < ApplicationController
  before_action :get_institutions_json, :get_locations_json

  def index
  end
end