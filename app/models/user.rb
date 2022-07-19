class User < ApplicationRecord
    # every user object's parameter email will be downcased before saving into database
    before_save { self.email = email.downcase }
    # create association where user can have many posts, delete those dependencies when user is deleted
    has_many :posts, dependent: :destroy
    has_many :comments, dependent: :destroy
    
    has_many :user_collabs
    has_many :collabs, through: :user_collabs
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
    has_secure_password
    has_one_attached :image
end