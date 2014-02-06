class AuthorsController < ApplicationController

  def index
    @authors = Author.all
    render json: @authors.select!('profile', 'id')
  end

end