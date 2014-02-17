class CategoriesController < ApplicationController

  def index
    @categories = Category.api_data
    render json: @categories
  end

end
