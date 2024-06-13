# frozen_string_literal: true

def two_sum(nums, target)
  solution = {}

  nums.each_with_index do |n, i|
    required_n = target - n
    return [solution[required_n], i] if solution[required_n]

    solution[n] = i
  end
end
