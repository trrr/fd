class AuthorsController < ApplicationController

  def index
    @authors = Author.api_data
    render json: @authors
  end

end
