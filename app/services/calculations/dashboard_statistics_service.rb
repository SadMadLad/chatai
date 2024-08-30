module Calculations
  class DashboardStatisticsService < BaseService
    ASSOCIATIONS_GROUPED_BY_CREATED_AT = %i[collections favorites flash_cards collected_items quizzes quiz_undertakings].freeze

    def initialize(account)
      @account = account
    end

    def call
      count_associations_by_created_at
        .merge(quizzes_statistics)
        .merge(favorites_statistics)
        .with_indifferent_access
    end

    private

    def quizzes_statistics
      {
        quiz_undertaking_stats:,
        quizzes_grouped_by_undertakings_count:,
        average_rating_of_each_quiz:
      }
    end

    def favorites_statistics
      {
        quiz_favorites_statistics: @account.quizzes.joins(:favorites).group(:title).count,
        flash_cards_favorites_statistics: @account.flash_cards.joins(:favorites).group(:prompt).count,
        collections_favorites_statistics: @account.collections.joins(:favorites).group(:title).count,
      }
    end

    def quiz_undertaking_stats
      QuizUndertaking
        .quiz_undertakings_for_account(@account)
        .grouped_by_created_at
        .sort
        .to_h
    end

    def quizzes_grouped_by_undertakings_count
      @account.quizzes.joins(:quiz_undertakings).group('quizzes.title').count
    end

    def average_rating_of_each_quiz
      items_to_pluck = %i[id title total_rating ratings_count]

      @account.quizzes.pluck(*items_to_pluck).map do |id, title, total_rating, ratings_count|
        denominator = ratings_count.zero? ? 1 : ratings_count
        average_rating = total_rating.to_f / denominator

        [id, { title:, average_rating: }]
      end.to_h
    end

    def count_associations_by_created_at
      ASSOCIATIONS_GROUPED_BY_CREATED_AT.map do |association_name|
        [
          "#{association_name}_grouped_by_created_at",
          @account.public_send(association_name).grouped_by_created_at.sort.to_h
        ]
      end.to_h
    end
  end
end
