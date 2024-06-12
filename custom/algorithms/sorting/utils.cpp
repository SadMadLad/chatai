#pragma once

#include <iostream>
#include <vector>

void test_sort(std::string algorithm_name, void (*sorting_algorithm)(std::vector<int>&))
{
  std::vector<int> arr = {65, 14, 20, 30, 7, 80};

  std::cout << "Testing " << algorithm_name << std::endl
            << std::endl;

  std::cout << "Printing unsorted array:" << std::endl;
  for (int n : arr)
    std::cout << n << ' ';
  std::cout << std::endl;

  sorting_algorithm(arr);

  std::cout << "Printing sorted array:" << std::endl;
  for (int n : arr)
    std::cout << n << ' ';

  std::cout << "\n\n";
}
