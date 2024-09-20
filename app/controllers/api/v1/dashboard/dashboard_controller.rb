# frozen_string_literal: true

module Api
  module V1
    module Dashboard
      class DashboardController < Api::AuthenticatedController
        def index
          render json: Calculations::DashboardStatisticsService.new(current_account).call
        end
      end
    end
  end
end
