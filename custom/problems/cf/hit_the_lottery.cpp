#pragma once

#include <iostream>
#include <vector>

unsigned int hit_the_lottery(unsigned long int n)
{
  if (n <= 0)
    return 0;
  if (n == 1)
    return 1;

  unsigned int num = 0;
  int quotient = 0;

  if (n / 100 != 0)
  {
    quotient = n / 100;
    n -= quotient * 100;
    num += quotient;
  }
  if (n / 20 != 0)
  {
    quotient = n / 20;
    n -= quotient * 20;
    num += quotient;
  }
  if (n / 10 != 0)
  {
    quotient = n / 10;
    n -= quotient * 10;
    num += quotient;
  }
  if (n / 5 != 0)
  {
    quotient = n / 5;
    n -= quotient * 5;
    num += quotient;
  }
  quotient = n / 1;
  n -= quotient * 1;
  num += quotient;

  return num;
}

void test_hit_the_lottery()
{
  unsigned long int n = 1000000000;

  std::cout << "Testing Hit The Lottery\n";
  std::cout << "Withdrawal amount: " << n << std::endl;

  int sol = hit_the_lottery(n);
  std::cout << "Minimum number of notes (with 100, 20, 10, 5, 1): " << sol << std::endl;

  std::cout << "\n\n";
}
