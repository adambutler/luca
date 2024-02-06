# frozen_string_literal: true

class IconComponent < ViewComponent::Base
  include MaterialIcons::MaterialIconHelper
  include ActiveAttr::Model

  attribute :icon, default: :star
  attribute :size, default: :base
  attribute :color, default: :slate
  attribute :container_class, default: ""

  def css_classes
    [
      "text-#{color}-500"
    ].join(" ")
  end

  def size_class
    "text-#{size}"
  end
end
