# frozen_string_literal: true

class CalendarDateComponent < ViewComponent::Base
  include ActiveAttr::Model

  attribute :date
  attribute :disabled, default: false
  attribute :selected, default: false

  renders_many :emojis

  def highlight_selected?
    selected && !date.today?
  end

  def button_css_classes
    base = ["block mx-auto grow m-1 p-1 flex flex-col items-center justify-items-start rounded text-lg"]
    base << (disabled ? "text-slate-600" : "text-slate-400 font-bold")
    base << (date.today? ? "text-blue-100 bg-blue-900 hover:bg-blue-700" : "hover:bg-slate-700")
    base << (highlight_selected? ? "text-green-100 bg-green-900 hover:bg-green-700" : "")

    base.join(" ")
  end
end
