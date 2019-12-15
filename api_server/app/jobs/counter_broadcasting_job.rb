class CounterBroadcastingJob < ApplicationJob
  queue_as :default

  def perform
    return unless Counter.buffer.present?
    Counter.lock! do
      CounterChannel.broadcast_to('default', {
        time: Time.zone.now.to_i,
        count: Counter.count,
        buffer: Counter.buffer,
      })
      Counter.reset_buffer!
    end
    Counter.backup_database!
  end
end
