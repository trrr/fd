require 'spec_helper'
require 'json'
require 'koala'

describe PostsFetcher do
  let(:token) {Koala::Facebook::OAuth.new("1419909291585700", "ff5c45bb0c190064ba21b3b9480beb14")}
  let(:fb_api) {Koala::Facebook::API.new(token.get_app_access_token)}
  let(:data) {fb_api.get_connections("nokia", 'posts')}
  # let (:raw_post) {data[1]}
  let(:posts) {PostsFetcher.serialize_posts(data)}
  let(:author) {Author.create(profile: "nokia")}

  it "works" do
    pending "Stub the network!"
    pending "RIght now it's more of a smoke test, i.e. - it doesn't exlode when i run it"
  end

  it "serializes posts" do 
    serialized_data = PostsFetcher.serialize_posts(data)
    expect(serialized_data.class).to be Array
    expect(serialized_data.count).to be > 0
  end

  it "extracts data from raw json" do
    pending "Stub the network!"
    # post = PostsFetcher.extract_post_from_raw_post(raw_post)
    # expect(post.post_id).to eq raw_post[:id]
  end

  it "fetchs posts" do
    PostsFetcher.fetch_posts(author)
  end

  it "saves posts" do
    PostsFetcher.save_posts(posts, author)
    expect(author.posts.length).to eq posts.length
  end

  it "removes existing posts" do
    PostsFetcher.remove_existing_posts(posts, author)
  end

  it "worker integration test tests" do
    PostsFetcher.fetch_and_save_author_posts(author)
    expect(author.posts.count).to be > 5
  end

end