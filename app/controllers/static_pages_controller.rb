class StaticPagesController < ApplicationController
  before_action :set_serch_type, only: [:index]
  before_action :get_institutions_json, :get_locations_json

  def index
    if params[:search] || params[:search_type]
      @questions = Question.search_by_full_name(params[:search]).with_pg_search_highlight
      @rights = Right.by_school_type(session[:search_type]).search_by_full_title(params[:search]).with_pg_search_highlight
      respond_to do |format|
          format.js{
            render :template => "static_pages/index.js.haml",
                  :layout => false
          }
      end
    end
  end

  def about_us
  end

  private
  def set_serch_type
    if session[:search_type]
      if params[:search_type]
        session[:search_type] = params[:search_type]
      end
    else
      session[:search_type] = "secundaria"
    end
  end
end