class ResponsesController < ApplicationController
  def test
    render json: { greeting: "hello" }
  end
end
