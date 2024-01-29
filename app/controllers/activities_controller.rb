class ActivitiesController < ApplicationController
  before_action :set_workout, only: %i[new create]
  before_action :set_activity, only: %i[ show edit update destroy ]

  # GET /activities
  def index
    @activities = Activity.all
  end

  # GET /activities/1
  def show
  end

  # GET /activities/new
  def new
    @activity = Activity.new
  end

  # GET /activities/1/edit
  def edit
  end

  # POST /activities
  def create
    @activity = Activity.new(activity_params)
    @activity.workout = @workout
    @activity.exercise = Exercise.find_by_title(params[:activity][:exercise_title])

    if @activity.save
      redirect_to @workout, notice: "Activity was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /activities/1
  def update
    if @activity.update(activity_params)
      redirect_to @activity, notice: "Activity was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /activities/1
  def destroy
    @activity.destroy!
    redirect_to workout_path(@activity.workout), notice: "Activity was successfully destroyed.", status: :see_other
  end

  private

    def set_workout
      @workout = Workout.find(params[:workout_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def activity_params
      params.require(:activity).permit(:workout_id, :exercise_id)
    end
end
