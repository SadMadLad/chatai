#include <iostream>
#include <vector>

#include "algorithms/sorting/bubble_sort.cpp"
#include "algorithms/sorting/count_sort.cpp"
#include "algorithms/sorting/insertion_sort.cpp"
#include "algorithms/sorting/selection_sort.cpp"
#include "algorithms/sorting/utils.cpp"

#include "problems/cf/hit_the_lottery.cpp"
#include "problems/container_with_most_water.cpp"
#include "problems/knapsack_01.cpp"
#include "problems/two_sum.cpp"

int main() {
  test_sort("Bubble Sort", bubble_sort);
  test_sort("Count Sort", count_sort);
  test_sort("Insertion Sort", insertion_sort);
  test_sort("Selection Sort", selection_sort);

  test_two_sum();
  test_container_with_most_water();
  test_knapsack_01();
  test_hit_the_lottery();

  return 0;
}
