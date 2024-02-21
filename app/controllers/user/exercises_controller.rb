class User::ExercisesController < ApplicationController
  before_action :set_user, only: %i[new create]

  # GET /users/:user_id/exercises/new
  def new
    @exercise = Exercise.new
  end

  # POST /users/:user_id/exercises
  def create
    @exercise = Exercise.new(exercise_params)
    @exercise.user ||= @user
    @exercise.ranking = 10

    if session[:last_visited_workout]
      @activity = Activity.create(
        workout_id: session[:last_visited_workout],
        exercise: @exercise,
      )

      if @exercise.save && @activity.save
        redirect_to workout_path(session[:last_visited_workout]), notice: "Exercise was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    else
      if @exercise.save
        redirect_to root_path, notice: "Exercise was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  private
    def set_user
      @user = User.find(params[:user_id])
    end

    def exercise_params
      params.require(:exercise).permit(:title, :description, :exercise_type, :body_part, :level, :equipment)
    end
end
