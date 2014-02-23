class PagesController < ApplicationController
  before_action :authorize!

  include HighVoltage::StaticPage

end