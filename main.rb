require_relative './lib/hash_map'

def title(text)
  "\n#{text}\n\n"
end

test = HashMap.new

# 1. Populate
puts title 'Populate hashmap'

test.set('apple', 'red')
test.set('banana', 'yellow')
test.set('carrot', 'orange')
test.set('dog', 'brown')
test.set('elephant', 'gray')
test.set('frog', 'green')
test.set('grape', 'purple')
test.set('hat', 'black')
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')

pp test

# 2. Overwrite
puts title 'Change some values'

test.set('carrot', 'very tasty')
test.set('dog', 'spot')
test.set('frog', 'says croak!')

pp test

# 3. Exceed load
puts title 'Add one more'

test.set('moon', 'silver')

pp test

# 4. Overwrite some more
puts title 'Change some more values'

test.set('jacket', 'fashionable')
test.set('kite', 'flying high')
test.set('carrot', 'nom nom')

pp test

# 5. Use the methods
puts title 'Play with the methods'

puts "#get(elephant) is #{test.get('elephant')}"
puts "#has?(moon) is #{test.has?('moon')}"
puts "#has?(sun) is #{test.has?('sun')}"
puts "#length is #{test.length}"
puts "#remove(lion) is #{test.remove('lion')}"
puts "#remove(sun) is #{test.remove('sun').inspect}"
puts "#length is #{test.length}"
puts "#keys are #{test.keys}"
puts "#values are #{test.values}"
puts "#remove(banana) is #{test.remove('banana')}"
puts "#remove(hat) is #{test.remove('hat')}"
puts "#entries are #{test.entries}"
puts '#clear'
test.clear
puts "#entries are #{test.entries}"

puts

pp test
