class HomeController < ApplicationController
  def index
    @events = Event.future.order(:start).limit(10)
  end
end
