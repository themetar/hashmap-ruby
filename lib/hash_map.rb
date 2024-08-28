require_relative 'hash_map/key_value'

class HashMap
  attr_reader :length

  def set(key, value)
    index = hash(key) % buckets.length

    raise IndexError if index.negative? || index >= buckets.length

    node = find_node(buckets[index], key)

    if node && node.key == key
      node.value = value
    elsif node
      node.next = KeyValue.new(key, value)
      self.length += 1
    else
      buckets[index] = KeyValue.new(key, value)
      self.length += 1
    end
  end

  def get(key)
    index = hash(key) % buckets.length

    raise IndexError if index.negative? || index >= buckets.length

    node = find_node(buckets[index], key)

    return node.value if node && node.key == key

    nil
  end

  def has?(key)
    index = hash(key) % buckets.length

    raise IndexError if index.negative? || index >= buckets.length

    node = find_node(buckets[index], key)

    !!(node&.key == key)
  end

  private

  attr_accessor :buckets
  attr_writer :length

  def initialize
    self.buckets = Array.new(16)
    self.length = 0
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end

  def find_node(node, key)
    return nil unless node

    until node.key == key || node.next.nil?
      node = node.next
    end

    node
  end
end
