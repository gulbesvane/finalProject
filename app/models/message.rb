class Message < ApplicationRecord
  belongs_to :collab
  belongs_to :user
  # specify that a comment belongs to a parent
  belongs_to :parent, class_name: 'Message', optional: true
  # comment has many comments, to look it up reference parent_id col in database
  has_many :messages, foreign_key: :parent_id
end
