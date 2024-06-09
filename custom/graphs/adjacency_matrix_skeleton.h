#pragma once

#include <iostream>
#include <unordered_map>
#include <vector>

class AdjacencyMatrix
{
private:
  unsigned int count;
  std::unordered_map<int, unsigned int> indexes;
  std::vector<std::vector<bool>> adjacencyMatrix;

public:
  AdjacencyMatrix();
  AdjacencyMatrix(const unsigned int &);
  AdjacencyMatrix(const std::vector<int> &);
  AdjacencyMatrix(const std::vector<std::vector<bool>> &);
  AdjacencyMatrix(const AdjacencyMatrix &);

  void appendNode(int);
  void removeNode(int);
  void connectNodes(int, int);
  void disconnectNodes(int, int);

  friend std::ostream &operator<<(std::ostream &, const AdjacencyMatrix &);
};
