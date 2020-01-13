class CounterChannel < ApplicationCable::Channel
  def subscribed
    reject unless Identifier.verified?(params['identifier'])
    stream_for('default')
    transmit(count: Counter.count)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def increment(data)
    reject unless Identifier.verified?(data['identifier'])
    reject if data['count'] < 0
    Counter.lock! do
      Counter.increment(data['identifier'], data['count'])
    end
  end
end
