require 'spec_helper'

describe CategoriesController do

  it "assigns @categories to categories in the db" do
    category = create(:category)
    get :index
    expect(assigns(:categories).first.to_json).to eq category.to_json(only: [:id, :name, :description])
  end

end
