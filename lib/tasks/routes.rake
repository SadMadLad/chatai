# frozen_string_literal: true

task routes: :environment do
  p `rails routes`
end
