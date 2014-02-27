class Api::V1::Feed::StatusesController < ApplicationController
  respond_to :json

  def index
    unless current_user
      render json: {}, :status => 404
    end

    sec = parse_time(params["time"])
    timestamp = Time.strptime(sec, '%s')
    puts timestamp
    statuses = recent_statuses(current_user, timestamp)

    unless no_friends
      statuses << current_user.approved_friends.map do |friend| 
        recent_statuses(friend, timestamp)
      end
    end

    found = StatusDecorator.decorate_collection(statuses.flatten.sort)
    # require 'pry'; binding.pry

    respond_with found.map { |status| build_response_from_status(status) }
  end

  private

  def no_friends
    current_user.approved_friends.compact.empty?
  end

  def parse_time(time)
    (time.to_f / 1000).to_s
  end

  def recent_statuses(user, timestamp)
    user.statuses.where(updated_at: (timestamp.to_time)..(Time.now)).take(10)
  end

  def build_response_from_status(status)
    {posted_at: status.posted_time_ago,
     status: status,
     token: status.user.decorate.current_token_image_sm,
     user: status.user}
  end

end
