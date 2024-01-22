module ActivitiesHelper
  def activiy_card_collapsable_link(activity)
    if params[:activity].to_s == activity.id.to_s
      workout_path(activity.workout)
    else
      workout_path(activity.workout, activity: activity.id)
    end
  end
end
