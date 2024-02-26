class ActivitiesController < ApplicationController
  include ActionView::RecordIdentifier
  
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

    if params[:query]
      @results = Search::Exercise.search(user: @workout.user, query: params[:query])
      @exercises = Exercise.where(id: @results["hits"].map { |hit| hit["document"]["id"] })
    else
      @suggestions = Exercise.suggested_exercises(workout: @workout)
    end
  end

  # GET /activities/1/edit
  def edit
  end

  # POST /activities
  def create
    @activity = ActivityBuilder.new(
      workout: @workout, exercise: Exercise.find(activity_params[:exercise_id])
    ).build!
    
    redirect_to workout_path(@workout, activity: @activity), notice: "Activity was successfully created."
  end

  # PATCH/PUT /activities/1
  def update
    if @activity.update(activity_params)
      redirect_to workout_path(@activity.workout, activity: @activity.id), notice: "Activity was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /activities/1
  def destroy
    @activity.destroy!
    redirect_to workout_path(@activity.workout), notice: "Activity was successfully destroyed.", status: :see_other
  end

  def search
    if params[:search][:query].present?
      redirect_to(new_workout_activity_path(query: params[:search][:query]))
    else
      redirect_to(new_workout_activity_path)
    end
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
      params.require(:activity).permit(:workout_id, :exercise_id, :emoji, :split)
    end
end
