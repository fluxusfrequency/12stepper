class NotFoundController < ApplicationController
  layout 'not_found'
  
  def index
    404
  end
end