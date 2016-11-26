require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def inspect
    p @store
  end

  def insert(num)
    unless self.include?(num)
      if @count == num_buckets
        resize!
      end
      self[num] << num
      @count += 1
    end

  end

  def remove(num)
    self[num].delete(num) if self[num].include?(num)
  end

  def include?(num)

    return true if self[num].include?(num)
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    if num == []
      @store[0]
    else
      @store[num.hash % num_buckets]
    end
  end

  def num_buckets
    @store.length
  end

  def resize!
    order_elements = @store.flatten
    @store = Array.new(num_buckets * 2) { Array.new }
    order_elements.each do |ele|
      i = ele % num_buckets
      @store[i] << ele
    end
  end
end
