class Users::RegistrationsController < Devise::RegistrationsController

  def after_update_path_for(resource)
    root_path
  end
end