class Api::V1::Feed::StatusesController < ApplicationController
  respond_to :json

  def index
    # unless current_user
    #   render json: {}, :status => 404
    # end

    sec = (params["time"].to_f / 1000).to_s
    timestamp = Time.strptime(sec, '%s')
    statuses = current_user.statuses.where(updated_at: (timestamp.to_time)..(Time.now)).take(10)
    unless current_user.approved_friends.compact.empty?
      statuses << current_user.approved_friends.map {|friend| friend.statuses.where(updated_at: (timestamp.to_time)..(Time.now)).take(10)}
    end
    statuses = StatusDecorator.decorate_collection(statuses.flatten.sort)
    statuses = statuses.map do |status|
      {status: status, token: "#{SobrietyCounter.token_for(status.user.last_drink)}_token_sm.png"}
    end
    respond_with statuses
  end

end
