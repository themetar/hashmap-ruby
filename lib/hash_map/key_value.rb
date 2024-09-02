class HashMap
  class KeyValue
    attr_reader :key
    attr_accessor :value, :next_node

    def find_prev_and_node(key)
      previous = nil
      node = self

      until node.nil? || node.key == key
        previous = node
        node = node.next_node
      end

      [previous, node]
    end

    def inspect
      "{#{key}, #{value}}" + (next_node ? " -> #{next_node.inspect}" : '')
    end

    def initialize(key, value, next_node = nil)
      @key = key
      @value = value
      @next_node = next_node
    end
  end
end
