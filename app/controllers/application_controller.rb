class ApplicationController < ActionController::Base
  layout :layout_by_resource
  # before_action :test_flash

  # def test_flash
  #   flash.notice = "test"
  # end

  private

  def layout_by_resource
    devise_controller? ? "devise" : "application"
  end
end
