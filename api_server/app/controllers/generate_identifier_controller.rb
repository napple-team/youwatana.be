class GenerateIdentifierController < ApplicationController
  def index
    render json: { identifer: SecureRandom.alphanumeric(16) }
  end
end
