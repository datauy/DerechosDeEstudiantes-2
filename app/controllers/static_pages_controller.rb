class StaticPagesController < ApplicationController
  def index
    if params[:search]
      @questions = Question.search_by_full_name(params[:search]).with_pg_search_highlight
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
end