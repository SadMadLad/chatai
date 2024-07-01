# frozen_string_literal: true

task routes: :environment do
  p `bundle exec rails routes`
end
