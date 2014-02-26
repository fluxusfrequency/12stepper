class Api::V1::Feed::StatusesController < ApplicationController
  respond_to :json

  def index
    unless current_user
      render json: {}, :status => 404
    end
    statuses = current_user.statuses.take(10)
    unless current_user.approved_friends.compact.empty?
      statuses << current_user.approved_friends.map {|friend| friend.statuses.take(10)}
    end
    statuses = StatusDecorator.decorate_collection(statuses.flatten.sort)

    respond_with found
  end

end
