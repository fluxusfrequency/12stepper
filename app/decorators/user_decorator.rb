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
    year_milestones.each do |n|
      return years_anniversary_message(n) if year_milestone?(n)
    end

    month_milestones.each do |n|
      return months_anniversary_message(n) if month_milestone?(n)
    end

    return false
  end

  private

  def year_milestones
    (20..1).to_a
  end

  def month_milestones
    [9, 6, 3, 2, 1]
  end

  def year_milestone?(n)
    Date.today - n.years == object.last_drink.to_date
  end

  def month_milestone?(n)
    Date.today - n.months == object.last_drink.to_date
  end

  def years_anniversary_message(n)
    t("flash.anniversary") + " " + t("flash.milestone") + " " + 
      pluralize(n, t("navbar.year")) + " " + t("navbar.sober") + "!"
  end

  def months_anniversary_message(n)
    t("flash.anniversary") + " " + t("flash.milestone") + " " + 
      pluralize(n, t("navbar.month")) + " " + t("navbar.sober") + "!"
  end

end
