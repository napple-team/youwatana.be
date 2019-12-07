class Identifier
  include Redis::Objects

  attr_accessor :id

  value :identifier, expiration: 30.minutes

  def initialize(id)
    @id = id
  end

  class << self
    def register(id: nil)
      id ||= generate_identifier
      new(id).identifier.value = id
    end

    def verified?(id)
      new(id).identifier.value.present?
    end

    private

    def generate_identifier
      SecureRandom.alphanumeric(16)
    end
  end
end
