# frozen_string_literal: true

class CardComponent < ViewComponent::Base
  include ActiveAttr::Model

  attribute :css_classes, default: ""
  attribute :padded, default: true
  attribute :flex, default: false

  def inner_css_classes
    a = [
      "block",
      "border",
      "rounded",
      "bg-slate-900",
      "border-slate-800",
      "backdrop-blur",
      "bg-opacity-90"
    ]

    a.push("p-6") if padded
    a.push("flex") if flex
    a << css_classes

    a.join(" ")
  end
end
