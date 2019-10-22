class CounterChannel < ApplicationCable::Channel
  def subscribed
    stream_from('default')
    transmit(count: Counter.count)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def increment(data)
    value = Counter.increment(data["count"])
    ActionCable.server.broadcast('default', count: value)
  end
end
