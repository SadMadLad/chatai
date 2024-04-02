# frozen_string_literal: true

module Structures
  class BinarySearchTree
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

    def search(key)
      if key.is_a?(Array)
        key.map { |k| _search(@head, k) }
      else
        _search(@head, key)
      end
    end

    def exists?(key)
      if key.is_a?(Array)
        key.map { |k| _search(@head, k).present? }
      else
        _search(@head, key).present?
      end
    end

    def delete(key)
      if key.is_a?(Array)
        key.each { |k| _delete(@head, k) }
      else
        _delete(@head, key)
      end
    end

    def length
      _length(@head, 0) - 1
    end

    def height
      _height(@head, 0)
    end

    def print(traversal: :inorder)
      _print(@head, traversal)
    end

    def to_a(traversal: :inorder)
      _to_a(@head, traversal)
    end

    private

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

    def _search(node, key)
      return node if node.nil? || node.key == key

      _search(key < node.key ? node.left : node.right, key)
    end

    def _delete(node, key)
      return node if node.nil?

      if node.key > key
        node.left = _delete(node.left, key)
        return node
      elsif node.key < key
        node.right = _delete(node.right, key)
        return node
      end

      if node.left.nil?
        node.right

      elsif node.right.nil?
        node.left

      else
        succ_parent = node
        succ = node.right

        until succ.left.nil?
          succ_parent = succ
          succ = succ.left
        end

        if succ_parent == node
          succ_parent.right = succ.right
        else
          succ_parent.left = succ.right
        end

        node.key = succ.key
        node
      end
    end

    def _length(node, n)
      return n+1 if node.nil?

      (_length(node.left, n) + _length(node.right, n))
    end

    def _height(node, h)
      return h if node.nil?

      [_height(node.left, h+1), _height(node.right, h+1)].max + 1
    end

    def _print(node, traversal)
      case traversal
      when :inorder
        inorder_traversal(node)
      when :preorder
        preorder_traversal(node)
      else
        postorder_traversal(node)
      end
    end

    def _to_a(node, traversal)
      return if node.nil?

      case traversal
      when :inorder
        to_a_inorder(node, [])
      when :preorder
        to_a_preorder(node, [])
      else
        to_a_postorder(node, [])
      end
    end

    def inorder_traversal(node)
      return if node.nil?

      inorder_traversal(node.left)
      Rails.logger.debug node.key
      inorder_traversal(node.right)
    end

    def preorder_traversal(node)
      return if node.nil?

      Rails.logger.debug node.key
      preorder_traversal(node.left)
      preorder_traversal(node.right)
    end

    def postorder_traversal(node)
      return if node.nil?

      postorder_traversal(node.left)
      postorder_traversal(node.right)
      Rails.logger.debug node.key

      return
    end

    def to_a_inorder(node, node_list)
      return node_list if node.nil?

      to_a_inorder(node.left, node_list)
      node_list << node.key
      to_a_inorder(node.right, node_list)
    end

    def to_a_preorder(node, node_list)
      return node_list if node.nil?

      node_list << node.key
      to_a_preorder(node.left, node_list)
      to_a_preorder(node.right, node_list)
    end

    def to_a_postorder(node, node_list)
      return node_list if node.nil?

      to_a_postorder(node.left, node_list)
      to_a_postorder(node.right, node_list)
      node_list << node.key
    end
  end
end
