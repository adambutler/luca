class Post < ApplicationRecord
  enum :post_type, %i[comment]
  
  belongs_to :subject, polymorphic: true
  belongs_to :author, class_name: "User"
end
