class Counter
  include Redis::Objects

  counter :count

  class << self
    def counter
      @counter ||= new
    end

    def increment(count = 1)
      counter.count.increment(count)
    end

    def count
      counter.count.value
    end
  end

  def id
    'counter'
  end
end
