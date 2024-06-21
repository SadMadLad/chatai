#pragma once

#include <iostream>
#include <vector>

int knapsack_01(int item_profits_count, unsigned int max_weight, const std::vector<int> &item_profits, const std::vector<int> &weights)
{
  std::vector<std::vector<int>> dp(item_profits_count + 1, std::vector<int>(max_weight + 1, 0));

  for (int item_profit_index = 1; item_profit_index <= item_profits_count; item_profit_index++)
  {
    for (int weight_index = 1; weight_index <= max_weight; weight_index++)
    {
      if (weights[item_profit_index - 1] <= weight_index)
      {
        dp[item_profit_index][weight_index] = std::max(item_profits[item_profit_index - 1] + dp[item_profit_index - 1][weight_index - weights[item_profit_index - 1]], dp[item_profit_index - 1][weight_index]);
      }
      else
      {
        dp[item_profit_index][weight_index] = dp[item_profit_index - 1][weight_index];
      }
    }
  }

  return dp[item_profits_count][max_weight];
}

void test_knapsack_01()
{
  std::cout << "Testing Knapsack 01\n";

  std::vector<int> item_profits = {1, 2, 5, 6};
  std::vector<int> weights = {2, 3, 4, 5};

  unsigned int max_weight = 8;
  unsigned int items_count = item_profits.size();

  std::cout << "Printings Items (with profits)" << std::endl;
  for (int item_profit : item_profits)
    std::cout << item_profit << ' ';

  std::cout << "\n";
  std::cout << "Printing the weights of the items" << std::endl;
  for (int weight : weights)
    std::cout << weight << ' ';

  std::cout << "\n";

  int solution = knapsack_01(items_count, max_weight, item_profits, weights);

  std::cout << "Maximum possible profit: " << solution;

  std::cout << "\n\n";
}
