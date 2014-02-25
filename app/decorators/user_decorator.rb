class UserDecorator < Draper::Decorator
  delegate_all
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::TranslationHelper

  def days_sober
    pluralize(days_ago(object.last_drink.to_time).to_i, I18n.t('navbar.day')) + " " + t('navbar.sober') + "!"
  end

  def days_ago(date)
    diff = Time.now - date.to_time
    return 1 if diff < 86400
    diff.to_i / 86400
  end
  
end
