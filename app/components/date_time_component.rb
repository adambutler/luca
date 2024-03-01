# frozen_string_literal: true

class DateTimeComponent < ViewComponent::Base
  include ActiveAttr::Model

  attribute :datetime, default: Time.now
end
