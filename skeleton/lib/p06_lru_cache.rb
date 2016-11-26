require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      val = @prc.call(key)
      update_link!(val)
    else
      calc!(key)
    end

  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    eject! if @max == count
    link = Link.new(key, @prc.call(key))

    link.next = @store.tail
    @store.tail.prev.next = link
    link.prev = @store.tail.prev
    @store.tail.prev = link

    @map[key] = link
    link.val
  end

  def update_link!(link)
    # suggested helper method; move a link to the end of the list
    link.prev.next = link.next
    link.next.prev = link.prev

    link.next = @store.tail
    @store.tail.prev.next = link
    link.prev = @store.tail.prev
    @store.tail.prev = link

  end

  def eject!
    @store.head.next = @store.first.next
    @store.first.next.prev = @store.head
  end
end
