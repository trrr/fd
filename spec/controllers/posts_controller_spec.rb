require 'spec_helper'

describe PostsController do

  let(:category) {create :category}
  let(:author) {create :author, category: category}

  let(:data) {JSON.parse(File.read("spec/response.json"))}
  let(:posts) {PostsFetcher.serialize_posts(data)}

  before { PostsFetcher.check_for_dublications_and_save_posts(posts, author) }

  it "returns last ten posts on a get request" do
    get :index
    expect(assigns(:posts).length).to eq 10
  end

  it "returns given amount of posts" do
    get :index, per_page: 7
    expect(assigns(:posts).length).to eq 7
  end

  it "returns posts from a given category" do
    get :index, categories_ids: category.id
    expect(assigns(:posts).map(&:category_id).uniq).to eq [category.id]
  end

  it "returns previous ten posts from a given id" do
    get :index, id: Post.first.id, behavior: "down"
    expect(assigns(:posts).last.updated_time).to eq "2014-02-06 13:33:18"
  end

  it "returns next ten posts from a given id" do
    get :index, id: Post.last.id, behavior: "up"
    expect(assigns(:posts).first.updated_time).to eq "2014-02-07 07:42:01"
  end

end
