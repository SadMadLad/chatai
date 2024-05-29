class Post < ApplicationRecord
  belongs_to :account

  validates :title, presence: true
  validates :body, presence: true

  has_many_attached :pictures
end
