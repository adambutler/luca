class ActivitySet < ApplicationRecord
  belongs_to :activity, touch: true

  default_scope { order(:created_at) }
  
  scope :warmup, -> { where(warmup: true) }
  scope :ordinary, -> { where(warmup: false) }
  
  def set_number
    sibilings.where(warmup: false).where("id < ?", id).count
      .then { |set_number| split? ? set_number / 2 : set_number }
      .then { |set_number| set_number + 1 }
  end

  def set_letter
    return nil unless split?

    sibilings.where(warmup: false).where("id < ?", id).count.even? ? "L" : "R"
  end

  def set_label
    "#{set_number}#{set_letter}"
  end

  def split?
    activity.split?
  end

  def sibilings
    activity.sets
  end

  def repetitions_goal=(value)
    rangeable = Rangeable.new(value)
    super(rangeable.database_value)
    self.repetitions_type = rangeable.type
  end

  def set_index
    sibilings.find_index(self)
  end

  def placeholder(attribute)
    return nil unless activity.previous

    previous_set = activity.previous.sets[set_index]

    # Handle the inex offset where the previous activity has a warmup
    # but the current activity does not.
    if activity.previous.has_warmup? && !activity.has_warmup?
      previous_set = activity.previous.sets[set_index + 1]
    end
    
    return nil unless previous_set

    value = previous_set.send(attribute)
    value = value.respond_to?(:prettify) ? value.prettify : value

    value ? "⟲ #{value}" : "-"
  end

  def copy_values_from_previous_set
    self.load_goal ||= sibilings.last&.load_goal || 20
    self.load_actual ||= sibilings.last&.load_actual || nil
    self.repetitions_goal ||= (sibilings.last&.repetitions_goal || (8..10))
    self.repetitions_actual ||= (sibilings.last&.repetitions_actual || nil)
    self.repetitions_type ||= (sibilings.last&.repetitions_type || "range")
    self.warmup ||= sibilings.empty?
  end
end
