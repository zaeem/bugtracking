class User::RegistrationsController < Devise::RegistrationsController
    before_action :configure_permitted_parameters
    USERTYPE = ['Manager', 'User', 'QA']
    protected
    
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    end
    
  end