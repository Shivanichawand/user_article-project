class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  private

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
  
  def after_sign_in_path_for(resource)
    if resource.is_a?(AdminUser)
      admin_dashboard_path
    else
      articles_path
    end
  end

  protected

  def configure_permitted_parameters
    permit_attrs(%i[name])
  end

  def permit_attrs(attrs)
    %i[sign_up ].each do |action|
      devise_parameter_sanitizer.permit(action, keys: attrs)
    end
  end

end
