class Counter
  include Redis::Objects

  counter :count
  hash_key :buffer
  lock :counter

  class << self
    def counter
      @counter ||= new
    end

    def increment(identifier, count = 1)
      counter.count.increment(count)
      counter.buffer.incrby(identifier, count)
    end

    def count
      counter.count.value
    end

    def buffer
      counter.buffer.value
    end

    def reset_buffer!
      counter.redis.del(counter.buffer.key)
    end

    def lock!
      counter.counter_lock.lock do
        yield
      end
    end
  end

  def id
    'counter'
  end
end
