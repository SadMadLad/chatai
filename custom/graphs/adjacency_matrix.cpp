#pragma once

#include <stdexcept>
#include "adjacency_matrix_skeleton.h"

AdjacencyMatrix::AdjacencyMatrix() : count(0), indexes({}), adjacencyMatrix({}) {}

AdjacencyMatrix::AdjacencyMatrix(const unsigned int &count)
{
  this->count = count;

  for (unsigned int i = 0; i < count; i++)
    indexes[i] = i;

  adjacencyMatrix = std::vector<std::vector<bool>>(count, std::vector<bool>(count, false));
}

AdjacencyMatrix::AdjacencyMatrix(const AdjacencyMatrix &M) : count(M.count), indexes(M.indexes), adjacencyMatrix(M.adjacencyMatrix) {}

AdjacencyMatrix::AdjacencyMatrix(const std::vector<int> &indexes)
{
  unsigned int count = 0;
  for (const int &index : indexes)
  {
    this->indexes[index] = count;
    count++;
  }

  this->count = count + 1;
  adjacencyMatrix = std::vector<std::vector<bool>>(this->count, std::vector<bool>(this->count, false));
}

std::ostream &operator<<(std::ostream &out, const AdjacencyMatrix &adjMatrix)
{
  if (adjMatrix.count <= 0)
    return out;

  out << "\t";
  for (const auto &it : adjMatrix.indexes)
  {
    out << it.first << "\t";
  }
  out << std::endl;

  for (const auto &itRow : adjMatrix.indexes)
  {
    out << itRow.first << "\t";
    for (const auto &itCol : adjMatrix.indexes)
      out << adjMatrix.adjacencyMatrix[itRow.second][itCol.second] << "\t";

    out << std::endl;
  }

  return out;
}
