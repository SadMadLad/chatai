#pragma once

#include <iostream>
#include <unordered_map>
#include <vector>

std::vector<int> two_sum(const std::vector<int> &nums, int target)
{
  int length = nums.size();
  int required_sum;
  std::unordered_map<int, int> solution = {};

  for (int i = 0; i < length; i++) {
    required_sum = target - nums[i];
    auto found = solution.find(required_sum);

    if (found != solution.end()) {
      return std::vector<int>({ solution[required_sum], i });
    } else {
      solution[nums[i]] = i;
    }
  }

  return std::vector<int>({});
}

void test_two_sum() {
  std::cout << "Testing Two Sum" << std::endl;

  std::vector<int> nums({ 2, 7, 9, 11 });
  int target_sum = 9;

  std::cout << "Input Array: " << std::endl;
  for(int n: nums)
    std::cout << n << ' ';
  std::cout << std::endl << "Target Sum: " << target_sum << std::endl;

  std::vector<int> two_sum_solution = two_sum(nums, target_sum);

  std::cout << "Printing Solution: " << std::endl;
  for(int n: two_sum_solution)
    std::cout << n << ' ';

  std::cout << "\n\n";
}
