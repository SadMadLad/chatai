#pragma once

const unsigned long int MAXN = 1000;

// Dynamic Programming example - memoization
static int binomial_coefficient(unsigned long int n, unsigned long int k)
{
  int bc[MAXN][MAXN]; // Initialize a 2d matric

  for (int i = 0; i <= n; i++)
    bc[i][0] = 1; // First column is all 1
  for (int j = 0; j <= n; j++)
    bc[j][j] = 1; // The diagonal is all 1

  for (int i = 1; i <= n; i++)
    for (int j = 1; j < i; j++)
      bc[i][j] = bc[i - 1][j - 1] + bc[i - 1][j];

  return bc[n][k];
}
