require 'spec_helper'

describe AuthorsController do

  let(:category) { create(:category) }

  it "assigns @authors to authors in the db" do
    author = create :author, category: category
    get :index
    expect(assigns(:authors).first.to_json).to eq author.to_json(only: [:id, :profile])
  end

end
