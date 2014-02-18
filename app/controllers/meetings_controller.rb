class MeetingsController < ApplicationController

  def index

  end

  def search_meetings
    @meetings = MeetingFinder::Search.by_zip(params[:zipcode])
    fail
  end

end
