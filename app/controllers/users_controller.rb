class UsersController < ApplicationController
  before_action :set_user, only: %i[show]

  # GET /users/1
  def show
    @workouts = @user.workouts
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
end
