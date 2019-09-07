class Users::SessionsController < Devise::SessionsController
  layout 'login'
    def after_sign_in_path_for(resource)
      root_path
    end

    def after_sign_out_path_for(resource)
      root_path
    end
  end