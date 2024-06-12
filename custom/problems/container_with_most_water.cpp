#pragma once

#include <iostream>
#include <vector>

int container_with_most_water(const std::vector<int> &height)
{
  int length = height.size();
  int low = 0, high = length - 1;
  int current_water = 0, max_water = 0;

  while (low < high)
  {
    current_water = std::min(height[low], height[high]) * (high - low);
    if (current_water > max_water)
      max_water = current_water;

    if (height[low] < height[high])
      low++;
    else if (height[high] < height[low])
      high--;
    else
    {
      low++;
      high--;
    }
  }

  return max_water;
}

void test_container_with_most_water()
{
  std::cout << "Testing Container With Most Water" << std::endl;

  std::vector<int> height({1, 8, 6, 2, 5, 4, 8, 3, 7});

  std::cout << "Input height: " << std::endl;
  for (int n : height)
    std::cout << n << ' ';
  std::cout << std::endl;

  int container_with_most_water_solution = container_with_most_water(height);

  std::cout << "Printing Solution: " << container_with_most_water_solution << std::endl;
  std::cout << "\n\n";
}
