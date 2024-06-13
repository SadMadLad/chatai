#pragma once

#include <iostream>
#include <vector>

void count_sort(std::vector<int> &array)
{
  int max = array[0];
  int length = array.size();

  for (int n : array)
    if (n > max)
      max = n;

  std::vector<int> countArray = std::vector<int>(max + 1);

  for (int n : array)
    countArray[n] += 1;

  int sum = 0;
  for (int i = 0; i < countArray.size(); i++)
  {
    sum = sum + countArray[i];
    countArray[i] = sum;
  }

  std::vector<int> sortedArray = std::vector<int>(length);

  int index = 0;
  for (int i = length; i > 0; i--)
  {
    countArray[array[i]]--;
    index = countArray[array[i]];
    sortedArray[index] = array[i];
  }

  for(int x : sortedArray)
    std::cout << x << ' ';
}
