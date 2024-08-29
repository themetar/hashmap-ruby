require_relative 'hash_map/key_value'

class HashMap
  include Enumerable

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

  def remove(key)
    index = hash(key) % buckets.length

    raise IndexError if index.negative? || index >= buckets.length

    node = buckets[index]

    return nil unless node

    previous = nil

    until node.key == key
      previous = node
      node = node.next
    end

    if node
      if previous
        previous.next = node.next
      else
        buckets[index] = node.next
      end

      self.length -= 1

      return node.value
    end

    return nil
  end

  def clear
    self.length = 0
    buckets.length.times { |i| buckets[i] = nil }
  end

  def each
    return to_enum unless block_given?

    buckets.each do |node|
      while node
        yield node.key, node.value
        node = node.next
      end
    end
  end

  def keys
    each.map { _1 }
  end

  def values
    each.map { _2 }
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
