class CounterChannel < ApplicationCable::Channel
  def subscribed
    stream_for('default')
    transmit(count: Counter.count)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def increment(data)
    value = Counter.increment(data['count'])
    self.class.broadcast_to('default', from: data['identifier'], count: value)
  end
end
