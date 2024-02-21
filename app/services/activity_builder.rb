class ActivityBuilder
  include ActiveAttr::Model

  attribute :workout
  attribute :exercise

  DEFAULT_WARMUP_LOAD = 20
  DEFAULT_LOAD = 40
  DEFAULT_WARMUP_REPETITIONS = 4..6
  DEFAULT_REPETITIONS = 8..10
  DEFAULT_REPETITIONS_TYPE = "range"
  DEFAULT_SET_COUNT = 3
  DEFAULT_SPLIT = false

  def build!
    build_activity!
    build_sets!

    ActiveRecord::Base.transaction do
      @activity.save!
      @sets.each(&:save!)
    end

    @activity.reload
  end

  def build_activity!
    @activity = Activity.new(
      workout: workout,
      exercise: exercise,
    )

    @activity.split = last_activity&.split || DEFAULT_SPLIT
  end

  def build_sets!
    @sets = []
    
    build_set!(last_activity_warmup_set, warmup: true) if build_warmpup_set?
    
    if last_activity
      last_activity.sets.ordinary.each do |set|
        build_set!(set, warmup: false)
      end
    else
      DEFAULT_SET_COUNT.times { build_set!(nil, warmup: false) }
    end
  end

  def build_set!(reference_set, warmup: false)
    @sets << ActivitySet.new(
      activity: @activity,
      load_goal: reference_set&.load_goal || (warmup ? DEFAULT_WARMUP_LOAD : DEFAULT_LOAD),
      repetitions_goal: reference_set&.repetitions_goal || (warmup ? DEFAULT_WARMUP_REPETITIONS : DEFAULT_REPETITIONS),
      repetitions_type: reference_set&.repetitions_type || DEFAULT_REPETITIONS_TYPE,
      warmup: reference_set&.warmup || warmup
    )
  end

  private

  def last_activity_warmup_set
    last_activity&.sets&.warmup&.last
  end

  def build_warmpup_set?
    return true if last_activity.nil?
    
    last_activity&.has_warmup?
  end

  def last_activity
    @activity.previous
  end

  def user
    workout.user
  end
end
