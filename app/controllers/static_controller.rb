class StaticController < ApplicationController
  def homepage
    redirect_to dashboard_path if user_signed_in?
  end
end
