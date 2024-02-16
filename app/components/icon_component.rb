# frozen_string_literal: true

class IconComponent < ViewComponent::Base
  include ActiveAttr::Model

  attribute :icon, default: :star
  attribute :size, default: :base
  attribute :color, default: :slate
  attribute :css_classes, default: ""

  def wrapper_css_classes
    [
      "text-#{color}-500",
      "text-#{size}",
      css_classes
    ].join(" ")
  end
end
