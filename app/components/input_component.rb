# frozen_string_literal: true

class InputComponent < ViewComponent::Base
  include ActiveAttr::Model

  attribute :form
  attribute :field
  attribute :type, default: :text
  attribute :collection, default: []
  attribute :input_html_options, default: {}
  # attribute :placeholder, default: ""
  # attribute :required, default: false
  # attribute :error_classes, default: ""
  # attribute :hint, default: ""
  # attribute :hint_classes, default: ""
  # attribute :disabled, default: false
  # attribute :readonly, default: false
  # attribute :autocomplete, default: "off"

  def input_method
    case type
    when :textarea then :text_area
    when :select then :select
    when :text then :text_field
    when :number then :number_field
    when :password then :password_field
    when :email then :email_field
    when :date then :date_field
    when :datetime then :datetime_field
    when :time then :time_field
    when :file then :file_field
    when :checkbox then :check_box
    when :radio then :radio_button
    when :hidden then :hidden_field
    when :search then :search_field
    when :tel then :tel_field
    when :url then :url_field
    end
  end

  def args
    case input_method
    when :select then [field, collection, select_options, options]
    else [field, options]
    end
  end

  def select_options
    {}
  end

  def options
    {
      class: input_classes
    }.merge(input_html_options)
  end

  def wrapper_classes
    "mb-4"
  end

  def label_classes
    "block text-sm font-medium text-slate-300 mb-2"
  end

  def input_classes
    "block w-full p-4 text-sm text-slate-400 border border-slate-800 rounded-lg bg-slate-900 focus:ring-blue-500 focus:border-blue-500"
  end
end
