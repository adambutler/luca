# frozen_string_literal: true

class CalendarComponent < ViewComponent::Base
  include ActiveAttr::Model

  class << self
    include EmojiHelper
  end
  
  attribute :date, default: -> { Date.today }
  attribute :annotations, default: -> { {} }

  def self.for_user_workouts(user:, date:)
    bang if date.nil?
    new(date: date).tap do |c|
      c.annotations = Activity
        .joins(workout: :user)
        .where(workout: { user: user })
        .select('workout.scheduled_at', :emoji)
        .map { |a| a.attributes.merge({
          "emoji" => emoji_key_to_emoji(a[:emoji]),
          "scheduled_at" => a[:scheduled_at].to_date
        }) }
        .group_by { |a| a["scheduled_at"] }
        .map { |k,v| [k, v.map { |vv| vv["emoji"] }] }
        .to_h
    end
  end

  def annotations_for_date(date_component:, date:)
    annotations.fetch(date, []).each do |emoji|
      date_component.with_emoji { emoji }
    end
  end
  
  def today
    Date.today
  end

  def next_button_link
    url_for(request.params.merge(date: date + 1.month))
  end

  def previous_button_link
    url_for(request.params.merge(date: date - 1.month))
  end

  def month_range
    starting_date..ending_date
  end

  def visible_date_range
    leading_date..trailing_date
  end

  def starting_date
    date.beginning_of_month
  end

  def ending_date
    date.end_of_month
  end

  def leading_date
    starting_date.beginning_of_week
  end

  def trailing_date
    ending_date.end_of_week
  end

  def title
    starting_date.strftime("%B %Y")
  end
end
