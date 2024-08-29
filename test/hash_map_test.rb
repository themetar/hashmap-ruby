# frozen_string_literal: true

require 'minitest'
require 'minitest/autorun'

require_relative '../lib/hash_map'

class HashMapTest < Minitest::Test
  def setup
    @hashmap = HashMap.new
  end

  def test_set
    @hashmap.set('somekey', 'somevalue')
    assert_equal 1, @hashmap.length
  end

  def test_has
    @hashmap.set('a', 5)
    assert @hashmap.has?('a')

    assert !@hashmap.has?('z')
  end

  def test_get
    @hashmap.set('mykey', 101)
    assert_equal 101, @hashmap.get('mykey')

    assert_nil @hashmap.get('nonexistent')
  end

  def test_remove
    @hashmap.set('mykey', 101)
    assert_equal 1, @hashmap.length
    
    @hashmap.set('otherkey', '200')
    assert_equal 2, @hashmap.length

    assert_equal 101, @hashmap.remove('mykey')
    assert_equal 1, @hashmap.length

    assert_nil @hashmap.remove('nonexistent')

    assert @hashmap.has?('otherkey')
    refute @hashmap.has?('mykey')
  end

  def test_clear
    10.times { |i| @hashmap.set('a' * (i + 1), 'b' * i) }
    assert_equal 10, @hashmap.length
    assert_equal 'bbbb', @hashmap.get('aaaaa')

    @hashmap.clear
    assert_equal 0, @hashmap.length
    assert_nil @hashmap.get('aaaaa')
  end
end
