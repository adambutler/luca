# frozen_string_literal: true

class DateTimeComponent < ViewComponent::Base
  include ActiveAttr::Model

  attribute :datetime, default: Time.now
  attribute :supplementary_text

  def self.for_workout(workout)
    supplementary_text = workout.location.blank? ? nil : "@ #{workout.location}"
    new(
      datetime: workout.scheduled_at,
      supplementary_text: supplementary_text
    )
  end
end
