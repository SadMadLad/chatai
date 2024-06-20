#pragma once

#include <iostream>
#include <vector>

int coin_change(std::vector<int> coins, unsigned int n, int sum) {
  if (sum == 0)
    return 1;

  if (sum < 0)
    return 0;

  if (n <= 0)
    return 0;

  return coin_change(coins, n-1, sum) + coin_change(coins, n, sum - coins[n-1]);
}

void test_coin_change() {
  std::cout << "Testing Coin Change" << std::endl;

  std::vector<int> nums({ 2, 5, 3, 6 });
  int target_sum = 10;

  std::cout << "Input Available Coins: " << std::endl;
  for(int n: nums)
    std::cout << n << ' ';
  std::cout << std::endl << "Target Sum: " << target_sum << std::endl;

  int coin_change_solution = coin_change(nums, nums.size(), target_sum);

  std::cout << "Printing Solution: " << coin_change_solution << std::endl;

  std::cout << "\n\n";
}
