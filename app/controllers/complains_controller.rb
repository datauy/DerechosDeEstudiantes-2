class ComplainsController < ApplicationController
  before_action :get_institutions_json, :get_locations_json
  def index
  end

  def new
    @complain = Complain.new
    if params['intern']
      @message=true
    end
  end

  def create
    @complain = Complain.new(complain_params)
    respond_to do |format|
      if @complain.save
        format.html {redirect_to new_complain_path(intern: true)}
      else
        format.html {redirect_to new_complain_path(), notice: 'Error al crear la denuncia' }
      end
    end
  end

  private
  def complain_params
    params.require(:complain).permit(:name, :email, :message)
  end
end