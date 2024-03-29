module ActivitiesHelper
  def activiy_card_collapsable_link(activity)
    if params[:activity].to_s == activity.id.to_s
      workout_path(activity.workout)
    else
      workout_path(activity.workout, activity: activity.id)
    end
  end

  def activiy_card_emoji_link(activity)
    workout_path(activity.workout, activity: activity.id, emoji_picker: true)
  end

  def activiy_card_comment_link(activity)
    workout_path(activity.workout, activity: activity.id, comment: true)
  end

  def activiy_card_config_link(activity)
    workout_path(activity.workout, activity: activity.id, config: true)
  end
end
