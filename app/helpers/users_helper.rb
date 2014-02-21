module UsersHelper
  def days_ago(date)
    diff = Time.now - date.to_time
    if diff < 86400
      return 1
    else
      diff.to_i / 86400
    end
  end
end
