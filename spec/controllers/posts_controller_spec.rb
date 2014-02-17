require 'spec_helper'

describe PostsController do

  let(:category) {create :category}
  let(:author) {create :author, category: category}

  let(:data) {JSON.parse(File.read("spec/response.json"))}
  let(:posts) {PostsFetcher.serialize_posts(data)}

  before { PostsFetcher.check_for_dublications_and_save_posts(posts, author) }

  it "returns last ten posts on a get request" do
    pending "now it returns all of them"
    get :index
    expect(assigns(:posts).length).to eq 10
  end

  it "returns given amount of posts" do
    get :index, per_page: 7
    expect(assigns(:posts).length).to eq 7
  end

end
