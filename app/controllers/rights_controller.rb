class RightsController < ApplicationController
  before_action :get_institutions_json, :get_locations_json

  def index
    @rights = Right.by_school_type(session[:search_type]).order(:title).page params[:page]
  end

  def show
    @right = Right.find(params[:id])
    @rights = Right.by_school_type_not_current(session[:search_type], @rights)
  end
end