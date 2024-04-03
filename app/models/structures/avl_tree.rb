module Structures
  class AvlTree < Structures::BinarySearchTree
    attr_accessor :head

    class Node
      attr_accessor :left, :right, :key

      def initialize(key)
        @key = key
        @left = nil
        @right = nil
      end
    end

    def initialize
      @head = nil
    end
    
  end
end
