class DashboardController < AuthenticatedController
  def index
    @workouts = current_user.workouts
    @clients = current_user.clients
  end
end
