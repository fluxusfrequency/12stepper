class StatusDecorator < Draper::Decorator
  delegate_all
  include ActionView::Helpers::DateHelper
  include ActionView::Helpers::TranslationHelper


  def posted_time_ago
    message = ""

    message = I18n.t('statuses.ago') + " " if [:es, :fr].include?(I18n.locale) 
    message += time_ago_in_words(object.updated_at)
    
    if I18n.locale == :en
      message += " " + I18n.t('statuses.ago')
      message.capitalize!
    end

    message
  end

end