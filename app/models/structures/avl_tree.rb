module Structures
  class AvlTree
    include Structures::Helpers::BinaryTreeHelpers

    attr_accessor :head

    def initialize
      @head = nil
    end
  end
end
