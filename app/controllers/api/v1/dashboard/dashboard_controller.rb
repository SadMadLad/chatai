module Api
  module V1
    module Dashboard
      class DashboardController < Api::AuthenticatedController
        def index
          @collected_items_today_count = current_account.items.created_today.size
          @flash_cards_created_today_count = current_account.flash_cards.created_today.size
          @quizzes_published_today_count = current_account.quizzes.published.created_today.size
          @quizzes_taken_today_count = current_account.quiz_undertakings.distinct(:quiz).created_today.size
        end
      end
    end
  end
end
