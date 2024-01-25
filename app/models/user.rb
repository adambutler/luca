class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :workouts

  has_many :memberships_as_client, foreign_key: :client_id, dependent: :destroy, class_name: "ClientMembership"
  has_many :memberships_as_trainer, foreign_key: :trainer_id, dependent: :destroy, class_name: "ClientMembership"

  has_many :clients, through: :memberships_as_trainer
end
