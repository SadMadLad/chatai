# frozen_string_literal: true

module Admin
  # Account helpers for Admin Dashboard.
  module AccountsHelper
    TABLE_HEADERS = ['First Name', 'Last Name', 'Username', 'Role', 'Created At', 'Updated At', 'Actions'].freeze
    DISPLAY_COLUMNS = %i[first_name last_name username role created_at updated_at].freeze
  end
end
