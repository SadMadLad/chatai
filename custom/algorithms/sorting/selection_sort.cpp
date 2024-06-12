#pragma once

#include <iostream>
#include <vector>

/*
  Start from left, find the next minimum and then swap it with the current element.
*/

void selection_sort(std::vector<int> &array)
{
  unsigned int array_size = array.size();

  if (array_size < 1)
    return;

  int min_index = 0;

  for (int i = 0; i < array_size; i++)
  {
    min_index = i;

    for (int j = i; j < array_size; j++)
      if (array[j] < array[min_index])
        min_index = j;

    std::swap(array[min_index], array[i]);
  }
}
