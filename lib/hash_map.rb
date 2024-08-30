require_relative 'hash_map/key_value'

class HashMap
  include Enumerable

  LOAD_FACTOR = 0.75

  attr_reader :length

  def set(key, value)
    index = hash(key) % buckets.length

    raise IndexError if index.negative? || index >= buckets.length

    _, node = buckets[index] && buckets[index].find_prev_and_node(key)

    if node && node.key == key
      node.value = value
    else
      if length + 1 > buckets.length * LOAD_FACTOR
        grow_buckets!

        index = hash(key) % buckets.length

        raise IndexError if index.negative? || index >= buckets.length
      end

      buckets[index] = KeyValue.new(key, value, buckets[index])
      self.length += 1
    end
  end

  def get(key)
    node = get_node(key)

    return node.value if node && node.key == key

    nil
  end

  def has?(key)
    node = get_node(key)

    !!node
  end

  def remove(key)
    index = hash(key) % buckets.length

    raise IndexError if index.negative? || index >= buckets.length

    node = buckets[index]

    return nil unless node

    previous, node = node.find_prev_and_node(key)

    if node
      if previous
        previous.next_node = node.next_node
      else
        buckets[index] = node.next_node
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
        node = node.next_node
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

  def get_node(key)
    index = hash(key) % buckets.length

    raise IndexError if index.negative? || index >= buckets.length

    return nil unless buckets[index]

    _, node = buckets[index].find_prev_and_node(key)

    node
  end

  def grow_buckets!
    new_buckets = Array.new(buckets.length * 2)

    each do |key, value|
      index = hash(key) % new_buckets.length

      raise IndexError if index.negative? || index >= new_buckets.length

      new_buckets[index] = KeyValue.new(key, value, new_buckets[index])
    end

    self.buckets = new_buckets
  end
end
