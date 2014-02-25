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
    milestones.each do |milestone, message|
      if milestone.call == object.last_drink.to_date
        return t("flash.anniversary") + " " + t("flash.milestone") + " " + 
        message.call + " " + t("navbar.sober") + "!"
      end
    end
  end

  private

  def milestones
    { -> { Date.today - 1.year }   => -> { pluralize(1, t("navbar.year")) },
      -> { Date.today - 9.months } => -> { pluralize(9, t("navbar.month")) },
      -> { Date.today - 6.months } => -> { pluralize(6, t("navbar.month")) },
      -> { Date.today - 3.months } => -> { pluralize(3, t("navbar.month")) },
      -> { Date.today - 2.months } => -> { pluralize(2, t("navbar.month")) },
      -> { Date.today - 1.month }  => -> { pluralize(1, t("navbar.month")) } } 
  end

end
