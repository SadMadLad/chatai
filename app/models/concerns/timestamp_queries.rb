module TimestampQueries
  extend ActiveSupport::Concern

  included do
    %w[created updated].each do |timestamp|
      scope :"#{timestamp}_today", -> { where(timestamp => day_range) }
      scope :"#{timestamp}_yesterday", -> { where(timestamp => day_range(offset: 1.days)) }
      scope :"#{timestamp}_n_days_before", -> (n) { where(timestamp => day_range(offset: n.days)) }
      scope :"grouped_by_#{timestamp}_at", -> { group("DATE(#{timestamp})").count }
    end
  end

  class_methods do
    def day_range(offset: 0.days)
      (Time.zone.now.beginning_of_day - offset)..(Time.zone.now.end_of_day - offset)
    end
  end
end
