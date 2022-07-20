class Collab < ApplicationRecord
    #validate that a title and description are present and with a min and max lengths, before saving an article
    validates :title, presence: true, length: { minimum: 5, maximum: 150}
    validates :body, presence: true, length: { minimum: 25, maximum: 1000}
    validate :validate_image_attachement

    has_many :user_collabs, :dependent => :destroy
    has_many :users, through: :user_collabs

    has_one_attached :image, dependent: :destroy

    private
    def validate_image_attachement
        return unless image.attached?
  
        unless image.content_type.in?(%w[image/jpeg image/png image/jpg])
          errors.add(:attachments ,"You can only attach .jpeg .jpg or .png files")
        end
      end


end
