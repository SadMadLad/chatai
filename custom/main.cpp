#include <iostream>
#include <vector>

#include "algorithms/binomial_coefficient.h"
#include "graphs/adjacency_matrix.cpp"

int main() {
  AdjacencyMatrix A(8);
  AdjacencyMatrix B;
  AdjacencyMatrix C(std::vector<int>({ 9, 5, 4 }));
  AdjacencyMatrix D(C);

  std::cout << A;
  A.appendNode(33);
  std::cout << std::endl;

  std::cout << B;
  B.appendNode(20);
  B.appendNode(30);
  B.appendNode(20);
  std::cout << std::endl;

  std::cout << C;
  std::cout << std::endl;

  std::cout << D;
  std::cout << std::endl;

  return 0;
}
