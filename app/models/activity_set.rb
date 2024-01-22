class ActivitySet < ApplicationRecord
  belongs_to :activity, touch: true

  default_scope { order(:id) }
  
  after_initialize :setup_default_values

  def set_number
    sibilings.where(warmup: false).where("id < ?", id).count + 1
  end

  def sibilings
    activity.sets
  end

  def repetitions_goal=(value)
    case value
    when Range
      super(value)
    when String
      if value.match?(/\@\d?$/)
        int = value.match(/\@(\d)?$/)[1]
        self.repetitions_type = "limit"
        super(int..int)
      else
        self.repetitions_type = "range"
        super(Range.new(*value.split(/\.{2,3}|\-/).map(&:to_i)))
      end
    else
      raise ArgumentError, "Invalid value for repetitions_goal: #{value.inspect}"
    end
  end

  private

  def setup_default_values
    return unless activity

    self.load_goal ||= sibilings.last&.load_goal || 20
    self.repetitions_goal ||= (sibilings.last&.repetitions_goal || (8..10))
    self.repetitions_type ||= (sibilings.last&.repetitions_type || "range")
    self.warmup ||= sibilings.empty?
  end
end
