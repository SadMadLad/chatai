module Calculations
  class DashboardStatisticsService < BaseService
    ASSOCIATIONS_GROUPED_BY_CREATED_AT = %i[collections flash_cards items quizzes quiz_undertakings].freeze

    def initialize(account)
      @account = account
    end

    def call
      count_associations_by_created_at
    end

    private

    def count_associations_by_created_at
      ASSOCIATIONS_GROUPED_BY_CREATED_AT.map do |association_name|
        [association_name, @account.public_send(association_name).group_by_created_at]
      end.to_h
    end
  end
end
