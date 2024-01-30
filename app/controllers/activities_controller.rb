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

    if params[:query]
      search_parameters = {
        q: params[:query],
        query_by: "title",
        sort_by: "ranking:desc"
      }

      client = Typesense::Client.new(
        nodes: [{
          host: "localhost",
          port: 8108,
          protocol: "http"
        }],
        api_key: TypesenseConfig.api_key,
        connection_timeout_seconds: 2
      )

      @results = client.collections["exercises"].documents.search(search_parameters)
    end
  end

  # GET /activities/1/edit
  def edit
  end

  # POST /activities
  def create
    @activity = Activity.new(activity_params)
    @activity.workout = @workout
    @activity_set = @activity.sets.build

    ActiveRecord::Base.transaction do
      @activity.save!
      @activity_set.save!
      redirect_to @workout, notice: "Activity was successfully created."
    end
  rescue ActiveRecord::RecordInvalid
    render :new, status: :unprocessable_entity
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
      params.require(:activity).permit(:workout_id, :exercise_id, :emoji)
    end
end
