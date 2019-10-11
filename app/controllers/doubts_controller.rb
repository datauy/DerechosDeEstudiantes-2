class DoubtsController < ApplicationController

  def create
    @doubt = Doubt.new(doubt_params)
    @doubt.right_id = params['right_id']
    if @doubt.save
      redirect_to right_path(id: @doubt.right_id, finished: true)
    else
      redirect_to right_path(@doubt.right_id), notice: 'Error al crear el comentario'
    end
  end

  private
  def doubt_params
    params.require(:doubt).permit(:name, :email, :message)
  end
end