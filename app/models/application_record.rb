# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  attr_accessor :skip_broadcast_callbacks

  primary_abstract_class

  has_many :admin_comments, as: :admin_commentable, dependent: :destroy
end
