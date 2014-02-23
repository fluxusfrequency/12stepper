class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_locale

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize!
    unless current_user
      redirect_to root_path, :notice => t("flash.sign_in_first")
    end
  end

  def current_token
    SobrietyCounter.token_for(current_user.last_drink)
  end

  helper_method :current_user, :current_token


  private

  def set_locale
    if current_user
      I18n.locale = current_user.locale || params[:locale] || I18n.default_locale
    else
      I18n.locale = params[:locale] || I18n.default_locale
    end
  end

  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { locale: I18n.locale }
  end

end
