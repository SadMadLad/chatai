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

  void append_node(int);
  void remove_node(int);
  void connect_nodes(int, int);
  void disconnect_nodes(int, int);

  friend std::ostream &operator<<(std::ostream &, const AdjacencyMatrix &);
};
