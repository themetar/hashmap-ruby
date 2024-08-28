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
end
