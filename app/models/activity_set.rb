class ActivitySet < ApplicationRecord
  belongs_to :activity

  def set_number
    sibilings.where(warmup: false).where("id < ?", id).count + 1
  end

  def sibilings
    activity.sets
  end
end
