# frozen_string_literal: true

module Structures
  class BinarySearchTree
    include Structures::Helpers::BinaryTreeHelpers

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

    def insert(key)
      if key.is_a?(Array)
        key.each { |k| _insert(@head, k) }
      else
        _insert(@head, key)
      end
    end

    protected

    def _insert(node, key)
      return @head = Node.new(key) if @head.nil?

      return Node.new(key) if node.nil?

      if key < node.key
        node.left = _insert(node.left, key)
      else
        node.right = _insert(node.right, key)
      end

      node
    end
  end
end
