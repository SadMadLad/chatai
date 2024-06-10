#include <iostream>
#include <vector>

#include "algorithms/sorting/selection_sort.cpp"
#include "algorithms/sorting/bubble_sort.cpp"

int main() {
  std::vector<int> arr = {65, 14, 20, 30, 7, 80};
  bubble_sort(arr);

  for (int i = 0; i < arr.size(); i++)
    std::cout << arr[i] << ' ';

  std::cout << std::endl;

  return 0;
}
