# frozen_string_literal: true

module Admin
  class AdminPolicy
    RESOURCEFUL_ACTIONS = %w[index show new create edit update destroy].freeze
    ADMIN_SEPARATION_ACTIONS = %w[show edit update destroy].freeze

    attr_reader :user, :record

    def initialize(user, record)
      @user = user
      @record = record
    end

    RESOURCEFUL_ACTIONS.each do |action|
      define_method(:"#{action}?") do
        user.can_moderate?
      end
    end

    protected

    def authenticated?
      user.superadmin? || (record.user? && user.admin?)
    end

    def authorized_record?
      record.commenter == user || user.superadmin?
    end
  end
end
