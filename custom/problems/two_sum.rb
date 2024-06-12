def two_sum(nums, target)
  solution = {}

  nums.each_with_index do |n, i|
    required_n = target - n
    if solution[required_n]
      return [solution[required_n], i]
    else
      solution[n] = i
    end
  end
end
