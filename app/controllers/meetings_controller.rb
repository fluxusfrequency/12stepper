class MeetingsController < ApplicationController
  before_action :authorize!

  def index

  end

  def search_meetings
    coords = MeetingFinder::Search.find_lat_long_from(params[:address])
    lat_lng =
    @meetings = MeetingFinder::Search.by_lat_lng(coords.first, coords.last)
    package = {meetings: @meetings, search: lat_lng}
    respond_to do |format|
      format.html
      format.json { render json: @meetings }
    end
  end

  def request_reminder
    meeting = MeetingFinder::Meeting.find(params[:id])
    ReminderNotifier.meeting_reminder_email(current_user.email, meeting.name, meeting.location, meeting.address, meeting.time, meeting.day)
  end

end
