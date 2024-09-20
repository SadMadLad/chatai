# frozen_string_literal: true

module Api
  module V1
    module Dashboard
      class QuizzesController < Api::AuthenticatedController
        def index
          @quizzes = current_account.quizzes
        end
      end
    end
  end
end
