module UsersHelper
  def days_ago(date)
    diff = Time.now - date.to_time
    return 1 if diff < 86400
    diff.to_i / 86400
  end

  def print_days_sober(user)
    pluralize(days_ago(user.last_drink.to_time).to_i, I18n.t('navbar.day')) + " " + t('navbar.sober') + "!"
  end
end
