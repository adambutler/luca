class ActivitySetsController < ApplicationController
  before_action :set_activity_set, only: %i[ show edit update destroy ]

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
    @activity_set = ActivitySet.new(activity_set_params)

    if @activity_set.save
      redirect_to @activity_set, notice: "Activity set was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /activity_sets/1
  def update
    if @activity_set.update(activity_set_params)
      redirect_to @activity_set, notice: "Activity set was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /activity_sets/1
  def destroy
    @activity_set.destroy!
    redirect_to activity_sets_url, notice: "Activity set was successfully destroyed.", status: :see_other
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
