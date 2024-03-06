class ActivitySetsController < ApplicationController
  include ActivitySetsHelper

  layout false

  before_action :set_activity_set, only: %i[show edit update destroy toggle_warmup copy_load_from_goal copy_repetitions_from_goal]

  # GET /activity_sets
  def index
    @activity_sets = ActivitySet.all
  end

  # GET /activity_sets/1
  def show
  end

  # GET /activity_sets/new
  def new
    @activity_set = ActivitySet.new
  end

  # GET /activity_sets/1/edit
  def edit
  end

  # POST /activity_sets
  def create
    @activity_set = ActivitySet.new
    @activity_set.activity_id = params[:activity_id]
    @activity_set.copy_values_from_previous_set

    if @activity_set.save!
      redirect_to workout_path(@activity_set.activity.workout, activity: @activity_set.activity.id), notice: "Activity set was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /activity_sets/1
  def update
    @fields_to_rerender = activity_set_params.keys.map(&:to_sym)

    if @activity_set.update(activity_set_params)
      render :show, status: :ok
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /activity_sets/1
  def destroy
    workout = @activity_set.activity.workout
    @activity_set.destroy!
    redirect_to workout_path(workout, activity: @activity_set.activity.id), notice: "Activity set was successfully destroyed.", status: :see_other
  end

  def toggle_warmup
    if @activity_set.warmup?
      @activity_set.update(warmup: false)
    elsif @activity_set.set_number == 1 && !@activity_set.activity.has_warmup?
      @activity_set.update(warmup: true)
    end

    redirect_to workout_path(@activity_set.activity.workout, activity: @activity_set.activity.id), notice: "Activity set was successfully updated.", status: :see_other
  end

  def copy_load_from_goal
    @activity_set.update(load_actual: @activity_set.load_goal)

    @fields_to_rerender = [:load_actual]
    render "show", status: :ok
  end

  def copy_repetitions_from_goal
    @activity_set.update(repetitions_actual: repetitions_actual_copy_value(@activity_set))

    @fields_to_rerender = [:repetitions_actual]
    render "show", status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity_set
      @activity_set = ActivitySet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def activity_set_params
      params.require(:activity_set).permit(:load_goal, :load_actual, :repetitions_goal, :repetitions_actual, :repetitions_type, :warmup)
    end
end
