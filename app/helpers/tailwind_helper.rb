# frozen_string_literal: true

module TailwindHelper
  # So that we do not need string interpolation
  DYNAMIC_OPACITY = {
    10 => 'bg-opacity-10',
    20 => 'bg-opacity-20',
    30 => 'bg-opacity-30',
    40 => 'bg-opacity-40',
    50 => 'bg-opacity-50',
    60 => 'bg-opacity-60',
    70 => 'bg-opacity-70',
    80 => 'bg-opacity-80',
    90 => 'bg-opacity-90',
    100 => 'bg-opacity-100'
  }.freeze
end
