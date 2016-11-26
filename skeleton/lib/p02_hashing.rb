

class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    return super if self == []
    count = 0
    self.each_with_index do |c, i|
      next if c == []
      count += c.ord * i
    end
    count.hash
  end
end

class String
  def hash
    count = 0
    arr = self.chars
    arr.each_with_index do |c, i|
      count += c.ord * i
    end
    count.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    return 0 if self.empty?
    count = 0
    key_mult = 1
    val_mult = 5
    self.each do |key, val|
      count += key.to_s.ord * key_mult

      count += val.to_s.ord * val_mult

    end
    count.hash
  end

end
