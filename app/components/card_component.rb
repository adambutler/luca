# frozen_string_literal: true

class CardComponent < ViewComponent::Base
  include ActiveAttr::Model

  attribute :css_classes, default: ""
end
