#pragma once

#include <vector>
#include <iostream>

/*
  Start from the left, swap the number to its right if its greater than the number
  on the right. In short, the maximum number will bubble up at the end.
*/

void bubble_sort(std::vector<int> &array)
{
  unsigned int array_size(array.size());

  if (array_size < 1)
    return;

  bool swapped = false;

  for (int i = 0; i < array_size; i++)
  {
    swapped = false;
    for (int j = 0; j < array_size - i - 1; j++)
    {
      if (array[j] > array[j + 1])
      {
        std::swap(array[j], array[j + 1]);
        swapped = true;
      }
    }

    if (!swapped)
      return;
  }
}
