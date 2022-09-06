class ComplainsController < ApplicationController
  before_action :get_institutions_json, :get_locations_json
  before_action :get_both_institutions
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
    success = verify_recaptcha(action: 'complain', minimum_score: 0.5, secret_key: Rails.application.credentials.recaptcha_secret_key)
    checkbox_success = verify_recaptcha unless success
    respond_to do |format|
      if (success || checkbox_success) && @complain.save
        format.html {redirect_to new_complain_path(intern: true)}
      elsif !success
        @show_checkbox_recaptcha = true
      else
        format.html {redirect_to new_complain_path(), notice: 'Error al crear el reporte' }
      end
    end
  end

  private
  def get_both_institutions
      file = File.open "#{Rails.root}/public/utu.json"
      json_institutions = JSON.load file
      @array_institutions_utu = json_institutions['establecimientos'].map { |e| e['nombre'] }.join(',')
      file = File.open "#{Rails.root}/public/secundaria.json"
      json_institutions = JSON.load file
      @array_institutions_secundaria = json_institutions['establecimientos'].map { |e| e['nombre'] }.join(',')
  end

  def complain_params
    params.require(:complain).permit(:name, :email, :phone, :location, :institution, :to_who, :message)
  end
end
