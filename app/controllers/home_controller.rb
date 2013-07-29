class HomeController < ApplicationController
  def index
    @events = Event.future.order(:start).limit(5)
  end
end
