class RightsController < ApplicationController
  before_action :get_institutions_json, :get_locations_json

  def show
    @right = Right.find(params[:id])
    @rights = Right.by_school_type_not_current(session[:search_type], @right)
    if params['finished']
      @message=true
    end
  end

  def update
    @right = Right.find(params[:id])
    @right.count_help = @right.count_help + 1
    respond_to do |format|
      if @right.save
        return true
      end
      return false
    end
  end
end