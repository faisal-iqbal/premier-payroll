class HomeController < ActionController::Base
  before_filter :authenticate_user!
  before_filter :set_tab
  layout 'application'

  def index
  end

  private
  def set_tab
    @nav_tab = 'home'
  end
end