#pragma once

#include <iostream>
#include <vector>

/*
  Start from the left (most of the time skipping the first number). Take the next number
  as a key and insert it into its sorted position by moving it back in the array.
*/

void insertion_sort(std::vector<int> &array)
{
  int length = array.size();

  for (int i = 1; i < length; i++)
  {
    int j = i - 1;
    int key = array[i];

    while (j >= 0 && array[j] > key)
    {
      array[j + 1] = array[j];
      j--;
    }
    array[j + 1] = key;
  }
}
