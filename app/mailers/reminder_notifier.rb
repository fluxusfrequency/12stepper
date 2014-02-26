class ReminderNotifier < ActionMailer::Base
  include Resque::Mailer
  default from: "navyosu@gmail.com"

  def meeting_reminder_email(email, meeting_name, meeting_location, meeting_time, meeting_day)
    @meeting_name = meeting_name
    @meeting_location = meeting_location
    @meeting_time = meeting_time
    @meeting_day = meeting_day
    mail(to: email,
      subject: "Reminder for #{meeting_name} meeting at #{meeting_time}")
  end

end
