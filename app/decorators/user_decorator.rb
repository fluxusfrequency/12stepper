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

  def current_token_image
    "#{SobrietyCounter.token_for(object.last_drink)}_token.png"
  end

  def display_milestone_congrats
    if Date.today - 1.year == object.last_drink.to_date
      return t("flash.anniversary") + " " + t("flash.milestone") + " " + 
        pluralize(1, t("navbar.year")) + " " + t("navbar.sober") + "!"
    end

    [9, 6, 3, 2, 1].each do |i|
      if Date.today - i.months == object.last_drink.to_date
        return t("flash.anniversary") + " " + t("flash.milestone") + " " + 
          pluralize(i, t("navbar.month")) + " " + t("navbar.sober") + "!"
      end
    end
    return 
  end


end
