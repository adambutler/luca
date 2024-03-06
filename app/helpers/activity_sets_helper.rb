module ActivitySetsHelper
  def repetitions_goal_value(set)
    case set.repetitions_type
      when "range" then [set.repetitions_goal.min, set.repetitions_goal.max].uniq.join("-")
      when "limit" then set.repetitions_goal.min
      when "target" then set.repetitions_goal.min
    end
  end

  def repetitions_actual_copy_value(set)
    case set.repetitions_goal
    when NilClass then nil
    when Range then set.repetitions_goal.max
    end
  end

  def activity_set_field_type_for_field(field:)
    case field
    when :load_goal, :load_actual, :repetitions_actual then :number_field
    when :repetitions_goal then :text_field
    end
  end

  def activity_set_field_options_for_field(set:, field:)
    options = {}

    options[:id] = dom_id(set, field)
    options[:data] = {test_id: "activity_card_set_#{field}_input"}
    options[:onchange] = "this.form.requestSubmit()"
    options[:class] = "w-full p-1 text-slate-300 rounded bg-slate-900 bg-opacity-50 border-[#282531] ring-emerald-500 border font-semibold text-sm"
    options[:value] = activity_set_value_for_field(set: set, field: field)
    options[:placeholder] = activity_set_placeholder_for_field(set: set, field: field)

    options[:step] = case field
    when :load_goal, :load_actual then "0.1"
    when :repetitions_actual then "1"
    else nil
    end

    options[:inputmode] = case field
    when :load_goal, :load_actual then "decimal"
    when :repetitions_actual then "numeric"
    else nil
    end

    options
  end

  def activity_set_value_for_field(set:, field:)
    case field
    when :load_goal then set.load_goal&.prettify
    when :load_actual then set.load_actual&.prettify
    when :repetitions_goal then repetitions_goal_value(set)
    when :repetitions_actual then set.repetitions_actual
    end
  end

  def activity_set_placeholder_for_field(set:, field:)
    case field
    # when :load_goal then set.load_goal&.prettify
    when :load_actual then set.placeholder(:load_actual)
    # when :repetitions_goal then repetitions_goal_value(set)
    when :repetitions_actual then set.placeholder(:repetitions_actual)
    end
  end
end
