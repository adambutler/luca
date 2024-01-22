class Workout < ApplicationRecord
  belongs_to :user
  has_many :activities, dependent: :destroy

  default_scope { order(:created_at) }

  broadcasts_refreshes
end
