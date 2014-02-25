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
    if milestone?(object.last_drink.to_date)
      t("flash.milestone") + " " + 
      pluralize(days_ago(object.last_drink), t("navbar.day")) + " " +
      t("navbar.sober") + "!"
    end
  end

  private

  def milestone?(date)
    [ Date.today - 1.month, 
      Date.today - 2.months, 
      Date.today - 3.months, 
      Date.today - 6.months, 
      Date.today - 9.months, 
      Date.today - 1.year ].any? do |milestone| 
       date == milestone
      end
  end

end
