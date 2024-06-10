#pragma once

#include <iostream>
#include <vector>

#include "adjacency_matrix.cpp"

void adjacency_matrix_test() {
  AdjacencyMatrix A(8);
  AdjacencyMatrix B;
  AdjacencyMatrix C(std::vector<int>({ 9, 5, 4 }));
  AdjacencyMatrix D(C);

  std::cout << A;
  A.append_node(33);
  std::cout << std::endl;

  std::cout << B;
  B.append_node(20);
  B.append_node(30);
  B.append_node(20);
  std::cout << std::endl;

  std::cout << C;
  std::cout << std::endl;

  std::cout << D;
  std::cout << std::endl;
}
