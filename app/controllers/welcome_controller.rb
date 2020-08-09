class WelcomeController < ApplicationController
  skip_before_action :authenticate, only: :index

  def index
    @events = Event.where('start_at > ?', Time.zone.now).order(:start_at)
  end
end
