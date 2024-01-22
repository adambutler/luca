module ActivitySetsHelper
  def repetitions_goal_value(set)
    a = [set.repetitions_type == "limit" ? "@" : nil]
    a << [set.repetitions_goal.min, set.repetitions_goal.max].uniq.join("-")

    a.compact.join
  end
end
