# frozen_string_literal: true

# == Schema Information
#
# Table name: tag_maps
#
#  id            :bigint           not null, primary key
#  taggable_type :string           not null
#  taggable_id   :bigint           not null
#  tag_id        :bigint           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Intermediary table between Tag and Models with tags.
class TagMap < ApplicationRecord
  belongs_to :taggable, polymorphic: true
  belongs_to :tag

  validates :tag_id, uniqueness: { scope: %i[taggable_id taggable_type] }
end
