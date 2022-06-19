class Post < ApplicationRecord
    acts_as_taggable
    #validate that a title and description are present and with a min and max lengths, before saving an article
    validates :title, presence: true, length: { minimum: 5, maximum: 150}
    validates :body, presence: true, length: { minimum: 25, maximum: 1000}
end
