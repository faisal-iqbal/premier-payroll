class MainController < ActionController::Base
  layout 'application'
  before_filter :set_tab
  
  def index
  end

  private
  def set_tab
    @nav_tab = 'home'
  end
end