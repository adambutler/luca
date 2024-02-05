class DashboardController < AuthenticatedController
  def index
    @user = current_user
    @workouts = current_user.workouts
    @clients = current_user.clients
  end
end
