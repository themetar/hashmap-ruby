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

  def test_setting_more_values
    ('aa'...'bb').each_with_index do |key, i|
      @hashmap.set(key, i)
    end

    assert_equal 23, @hashmap.get('ax')
    assert_equal 26, @hashmap.get('ba')
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

  def test_entries
    expected = [
      ['a', 100],
      ['b', 200],
      ['c', 300],
      ['d', 400]
    ]

    expected.each { |k, v| @hashmap.set(k, v) }

    assert_equal(expected, @hashmap.entries.sort { |a, b| a.first <=> b.first })
  end

  def test_keys
    expected = %w[a b c d]

    expected.each { |k| @hashmap.set(k, rand(100)) }

    assert_equal expected, @hashmap.keys.sort
  end

  def test_values
    expected = [5, 14, 15, 32]

    expected.each { |v| @hashmap.set("k#{v}", v) }

    assert_equal expected, @hashmap.values.sort
  end
end
