require 'spec_helper'
require 'json'
require 'koala'

describe PostsFetcher do
  let(:token) {Koala::Facebook::OAuth.new("1419909291585700", "ff5c45bb0c190064ba21b3b9480beb14")}
  let(:fb_api) {Koala::Facebook::API.new(token.get_app_access_token)}
  let(:data) {fb_api.get_connections("nokia", 'posts')}
  let (:raw_post) {JSON.parse(File.read("spec/workers/post.json"))}
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
    post = PostsFetcher.extract_post_from_raw_post(raw_post)
    expect(post.message).not_to be_nil
    expect(post.post_id).to eq raw_post["id"]
  end

  it "fetchs posts" do
    a = Author.stub(:profile).with("nokia")
    expect{PostsFetcher.fetch_posts(a)}.not_to be_nil
  end

  context "integration tests" do

    it "fetchs and saves posts for given author" do
      PostsFetcher.fetch_and_save_author_posts(author)
      expect(author.posts.count).to be > 5
    end

    it "doesn't save duplicate posts" do
      PostsFetcher.fetch_and_save_author_posts(author)
      a = author.posts.count
      PostsFetcher.fetch_and_save_author_posts(author)
      expect(author.posts.count).to eq a
    end
  end
end