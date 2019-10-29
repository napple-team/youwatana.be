class GenerateIdentifierController < ApplicationController
  def index
    render json: { identifier: SecureRandom.alphanumeric(16) }
  end
end
