class AuthorsController < ApplicationController

  def index
    @authors = Author.all
    render json: @authors.as_json(only: [:id, :profile])
  end

end