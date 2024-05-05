# frozen_string_literal: true

module Admin
  # Base Policy for admin dashboard primarily.
  class AdminPolicy
    RESOURCEFUL_ACTIONS = %w[index show new create edit update destroy].freeze
    ADMIN_SEPARATION_ACTIONS = %w[show edit update destroy].freeze

    attr_reader :account, :record

    def initialize(account, record)
      @account = account
      @record = record
    end

    RESOURCEFUL_ACTIONS.each do |action|
      define_method(:"#{action}?") do
        account.can_moderate?
      end
    end

    protected

    # Allow superadmin anything but allow simple admins to do stuff of normal users.
    def authenticated?
      account.superadmin? || (record.user? && account.admin?)
    end

    def authorized_record?
      record.commenter == account || account.superadmin?
    end
  end
end
