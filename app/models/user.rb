class User < ApplicationRecord
    # validate username to be unique, present and its length
    validates :username, presence: true,
                 uniqueness: { case_sensitive: false },
                 length: { minimum: 3, maximum: 25 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    # validate email to be present, unique, length and valid format
    validates :email, presence: true,
                 uniqueness: { case_sensitive: false },
                 length: { maximum: 105 },
                 format: { with: VALID_EMAIL_REGEX }
end