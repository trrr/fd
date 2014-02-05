class CategoriesController < ApplicationController
  def index 
    @categories = Category.all
    render json: @categories.select!('id', 'name', 'description')
  end
end