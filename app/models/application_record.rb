# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  has_many :admin_comments, as: :admin_commentable, dependent: :destroy
end
