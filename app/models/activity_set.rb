class ActivitySet < ApplicationRecord
  belongs_to :activity, touch: true

  default_scope { order(:created_at) }
  scope :warmup, -> { where(warmup: true) }
  
  after_initialize :setup_default_values

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
    case value
    when Range
      super(value)
    when String
      if value.match?(/\@\d?$/)
        int = value.match(/\@(\d)?$/)[1]
        self.repetitions_type = "limit"
        super(int..int)
      else
        match = value.match(/^(\d+)(\.{2,3}|-)(\d+)$/)
        if match
          self.repetitions_type = "range"
          from = match[1].to_i
          range_operator = match[2]
          to = range_operator === "..." ? match[3].to_i - 1 : match[3].to_i
          super(from..to)
        else
          raise ArgumentError, "Invalid value for repetitions_goal: #{value.inspect}"
        end
      end
    else
      raise ArgumentError, "Invalid value for repetitions_goal: #{value.inspect}"
    end
  end

  private

  def setup_default_values
    return if persisted?
    return unless activity

    self.load_goal ||= sibilings.last&.load_goal || 20
    self.load_actual ||= sibilings.last&.load_actual || 20
    self.repetitions_goal ||= (sibilings.last&.repetitions_goal || (8..10))
    self.repetitions_actual ||= (sibilings.last&.repetitions_actual || (8..10))
    self.repetitions_type ||= (sibilings.last&.repetitions_type || "range")
    self.warmup ||= sibilings.empty?
  end
end
