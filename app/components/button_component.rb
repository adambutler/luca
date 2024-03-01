# frozen_string_literal: true

class ButtonComponent < ViewComponent::Base
  include ActiveAttr::Model

  attribute :type, default: :primary
  attribute :full_width, default: false
  attribute :submit, default: false

  def color
    case type
    when :primary then "frost hover:bg-purple-800"
    when :secondary then :slate
    when :danger then :red
    end
  end

  def classes
    [
      color,
      "text-white",
      "font-bold",
      "py-2",
      "px-4",
      "rounded",
      "transition",
    ].tap do |classes|
      classes << "w-full" if full_width
    end.join(" ")
  end

  def type_attribute
    submit ? "type=\"submit\"" : ""  
  end
end
