class HomeController < ApplicationController
  def index
    @upcoming_events = Event.future.order(:start).limit(5)
  end
end
