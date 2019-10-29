class CounterChannel < ApplicationCable::Channel
  def subscribed
    stream_for('default')
    transmit(count: Counter.count)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def increment(data)
    Counter.lock! do
      Counter.increment(data['identifier'], data['count'])
    end
  end
end
