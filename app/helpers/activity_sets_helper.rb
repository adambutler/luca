module ActivitySetsHelper
  def repetitions_goal_value(set)
    case set.repetitions_type
      when "range" then [set.repetitions_goal.min, set.repetitions_goal.max].uniq.join("-")
      when "limit" then set.repetitions_goal.min
      when "target" then set.repetitions_goal.min
    end
  end

  def repetitions_actual_copy_value(set)
    set.repetitions_goal.max
  end

  def can_copy_repetitions_actual_copy_value?(set)
    set.repetitions_type == "range"
  end
end
