class User < ApplicationRecord
    acts_as_voter
    # every user object's parameter email will be downcased before saving into database
    before_save { self.email = email.downcase }
    # create association where user can have many posts, delete those dependencies when user is deleted
    has_many :posts, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :messages, dependent: :destroy
    has_many :user_collabs, :dependent => :destroy
    has_many :collabs, through: :user_collabs
    # validate username to be unique, present and its length
    validates :username, presence: true,
                 uniqueness: { case_sensitive: false },
                 length: { minimum: 3, maximum: 25 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    # validate email to be present, unique, length and valid format using active record validation
    validates :email, presence: true,
                 uniqueness: { case_sensitive: false },
                 length: { maximum: 105 },
                 format: { with: VALID_EMAIL_REGEX }
    validates :password, length: { minimum: 8}
    has_secure_password

    validate :validate_image_attachement
    has_one_attached :image

    private
    def validate_image_attachement
      return unless image.attached?

      unless image.content_type.in?(%w[image/jpeg image/png image/jpg])
        errors.add(:attachments ,"You can only attach .jpeg .jpg or .png files")
      end
    end
end