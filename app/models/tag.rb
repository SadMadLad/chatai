class Tag < ApplicationRecord
  has_many :tag_maps, dependent: :destroy
  has_many :taggables, through: :tag_maps, dependent: :destroy

  validates :tag, presence: false
end
