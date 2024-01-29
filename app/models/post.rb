class Post < ApplicationRecord
  enum :post_type, %i[comment]
  
  belongs_to :subject, polymorphic: true
end
