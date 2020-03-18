class ErrorsController < ApplicationController
  def internal_server_error
    respond_to do |format|
      format.html { render status: 404 }
      format.any { render nothing: true, status: 404 }
    end
  end

  def not_found
    @not_found_path = params[:not_found]
    respond_to do |format|
      format.html {
        render status: 404
      }
      format.any {
        raise ActionController::RoutingError.new('Not Found')
      }
    end
  end
end
