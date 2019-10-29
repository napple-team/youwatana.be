class CounterBroadcastingJob < ApplicationJob
  queue_as :default

  def perform
    return unless Counter.buffer.present?
    Counter.lock! do
      CounterChannel.broadcast_to('default', {
        count: Counter.count,
        buffer: Counter.buffer,
      })
      Counter.reset_buffer!
    end
  end
end
