class Count < ApplicationRecord
  class NotDecreased < StandardError; end

  SINGLETON_ID = 1

  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }

  class << self
    def increment!(count)
      counter.update!(total: counter.total + count)
    end

    def update!(count)
      raise NotDecreased if count < total
      counter.update!(total: count)
    end

    def total
      counter.total
    end

    def counter
      @counter ||= find_or_initialize_by(id: SINGLETON_ID)
    end
  end
end
