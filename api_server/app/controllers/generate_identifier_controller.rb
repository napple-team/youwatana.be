class GenerateIdentifierController < ApplicationController
  def index
    render json: { identifier: Identifier.register }
  end
end
