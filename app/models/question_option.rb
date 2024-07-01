# frozen_string_literal: true

# == Schema Information
#
# Table name: question_options
#
#  id          :bigint           not null, primary key
#  question_id :bigint           not null
#  correct     :boolean          default(FALSE), not null
#  option_text :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Single option of a quiz
class QuestionOption < ApplicationRecord
  scope :randomize, -> { order('random()') }

  belongs_to :question

  validates :correct, boolean: true
  validates :option_text, presence: true
end
