class Post < ApplicationRecord
  belongs_to :account

  has_many_attached :images
  has_many :likes, as: :likeable

  validates :title, presence: true
  validates :body, presence: true
end
