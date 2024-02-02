class Post < ApplicationRecord
  enum :post_type, %i[comment]
  
  belongs_to :subject, polymorphic: true
  belongs_to :author, class_name: "User"

  def url
    case self.subject_type
    when "Activity"
      Rails.application.routes.url_helpers.workout_path(self.subject.workout, activity: self.subject.id)
    end
  end
end
