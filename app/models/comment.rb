class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  # specify that a comment belongs to a parent
  belongs_to :parent, class_name: 'Comment', optional: true
  # comment has many comments, to look it up reference parent_id col in database
  has_many :comments, foreign_key: :parent_id
end
