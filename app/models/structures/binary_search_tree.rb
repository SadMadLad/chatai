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
      _insert(@head, key)
    end

    def search(key)
      _search(@head, key)
    end

    def print(traversal: :inorder)
      _print(@head, traversal)
    end

    def to_a(traversal: :inorder)
      _to_a(@head, traversal)
    end

    private

    def _insert(node, key)
      if @head.nil?
        return @head = Node.new(key)
      else
        return Node.new(key) if node.nil?
      end

      if key < node.key
        node.left = _insert(node.left, key)
      else
        node.right = _insert(node.right, key)
      end

      return node
    end

    def _search(node, key)
      return node if node.nil? || node.key == key

      _search(key < node.key ? node.left : node.right, key)
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

      node_list = case traversal
                  when :inorder
                    to_a_inorder(node, [])
                  when :preorder
                    to_a_preorder(node, [])
                  else
                    to_a_postorder(node, [])
                  end

      node_list
    end

    def inorder_traversal(node)
      return if node.nil?

      inorder_traversal(node.left)
      p node.key
      inorder_traversal(node.right)
    end

    def preorder_traversal(node)
      return if node.nil?

      p node.key
      preorder_traversal(node.left)
      preorder_traversal(node.right)
    end

    def postorder_traversal(node)
      return if node.nil?

      postorder_traversal(node.left)
      postorder_traversal(node.right)
      p node.key
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
