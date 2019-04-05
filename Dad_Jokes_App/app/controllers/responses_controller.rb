class ResponsesController < ApplicationController
  def test
    @data = HTTParty.get("https://icanhazdadjoke.com/search", headers: {
                                                                Accept: "application/json",
                                                              })
    @data = @data["results"]
  end

  def random
    @data = HTTParty.get("https://icanhazdadjoke.com/", headers: {
                                                          Accept: "application/json",
                                                        })
    @data = @data["joke"]
  end
end
