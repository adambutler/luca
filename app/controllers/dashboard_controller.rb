class DashboardController < AuthenticatedController
  def index
    @workouts = current_user.workouts
  end
end
