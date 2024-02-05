# frozen_string_literal: true

class CarouselComponent < ViewComponent::Base
  include ActiveAttr::Model
  
  renders_many :slides

  attribute :starting_slide
end
