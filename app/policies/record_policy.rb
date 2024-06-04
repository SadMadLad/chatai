# frozen_string_literal: true

# Policy that allows user to create, see anything, but only allows edits and deletions for those records
# that are made by that specific user.
class RecordPolicy < ApplicationPolicy
  %w[edit update destroy].each do |action|
    define_method(:"#{action}?") { record_was_by_the_account? }
  end

  private

  def record_was_by_the_account?
    record.account == account
  end
end
