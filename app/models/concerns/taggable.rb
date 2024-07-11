module Taggable
  extend ActiveSupport::Concern

  included do
    has_many :tag_maps, as: :taggable, dependent: :destroy
    has_many :tags, through: :tag_maps
  end

  class_methods do
    def search_by_tags(search_by_or: false, tags: [])
      return all if tags.blank? && !(any_param_exists? [:tags]) 

      search_tags = @params&.[](:tags) || tags

      tagged_records = joins(:tags).where(tags: { tag: search_tags })
      return tagged_records if search_by_or
      
      tagged_records.group(:id).having('COUNT(DISTINCT tags.id) = ?', search_tags.length)
    end
  end
end
