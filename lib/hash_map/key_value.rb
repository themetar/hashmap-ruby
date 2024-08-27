class HashMap

  class KeyValue
    attr_reader :key
    attr_accessor :value, :next

    def initialize(key, value)
      @key = key
      @value = value
    end
  end

end
