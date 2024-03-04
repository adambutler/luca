# frozen_string_literal: true

class HeadingComponent < ViewComponent::Base
  include ActiveAttr::Model

  attribute :level

  def self.h1
    new(level: 1)
  end

  def self.h2
    new(level: 2)
  end

  def self.h3
    new(level: 3)
  end

  def self.h4
    new(level: 4)
  end

  def self.h5
    new(level: 5)
  end

  def self.h6
    new(level: 6)
  end

  def css_classes
    a = ["font-bold", "mb-4"]

    a << case level
    when 1 then "text-3xl"
    when 2 then "text-2xl"
    when 3 then "text-1xl"
    when 4 then "text-lg"
    when 5 then "text-base"
    when 6 then "text-sm"
    end

    a.join(" ")
  end
end
