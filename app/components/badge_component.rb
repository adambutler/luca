# frozen_string_literal: true

class BadgeComponent < ViewComponent::Base
  include ActiveAttr::Model

  attribute :color, default: "blue"
end
