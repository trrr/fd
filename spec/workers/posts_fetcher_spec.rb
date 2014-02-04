require 'spec_helper'
require 'json'
require 'koala'

describe PostsFetcher do
  let(:token) {Koala::Facebook::OAuth.new("1419909291585700", "ff5c45bb0c190064ba21b3b9480beb14")}
  let(:fb_api) {Koala::Facebook::API.new(token.get_app_access_token)}
  let(:data) {fb_api.get_connections("nokia", 'posts')}
  let (:raw_post) {data[0]}
  let(:posts) {PostsFetcher.serialize_posts(data)}
  let(:author) {Author.create(profile: "nokia")}

  pending "RIght now it's more of a smoke test, i.e. - it doesn't exlode when i run it"

  it "serializes posts" do 
    PostsFetcher.serialize_posts(data)
  end

  it "extracts data from raw json" do
    PostsFetcher.extract_post_from_raw_post(raw_post)
  end

  it "fetchs posts TODO: Use stub here" do
    PostsFetcher.fetch_posts(author)
  end

  it "saves posts" do
    PostsFetcher.save_posts(posts, author)
    expect(author.posts.length).to eq posts.length
  end

  it "removes existing posts" do
    PostsFetcher.remove_existing_posts(posts, author)
  end

  it "integrations tests" do
    PostsFetcher.fetch_and_save_author_posts(author)
  end

end