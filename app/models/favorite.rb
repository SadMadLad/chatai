# == Schema Information
#
# Table name: favorites
#
#  id               :bigint           not null, primary key
#  account_id       :bigint           not null
#  favoritable_type :string           not null
#  favoritable_id   :bigint           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Favorite < ApplicationRecord
  belongs_to :account
  belongs_to :favoritable, polymorphic: true
end
