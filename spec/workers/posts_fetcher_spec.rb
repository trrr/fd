require 'spec_helper'
require 'json'

describe PostsFetcher do
  let(:category) {create :category}
  let(:author) {create :author}
  let(:data) {JSON.parse(File.read("spec/response.json"))}
  let(:posts) {PostsFetcher.serialize_posts(data)}
  let(:amount_of_posts) {18}
  before {category.authors << author}

  context "serializing data and dropping posts with empty messages" do

    let(:serialized_data) {PostsFetcher.serialize_posts(data)}

    it "serializes posts (extracts data what we need)" do 
      expect(serialized_data.count).to eq amount_of_posts
    end

    it "drops posts with empty messages" do 
      expect(serialized_data.map(&:message).compact.count).to eq amount_of_posts
    end
  end

  context "extracting data from a single facebook post" do

    let(:raw_post) {JSON.parse(File.read("spec/workers/post.json"))}
    let(:post) {PostsFetcher.extract_post_from_raw_post(raw_post)}
    let(:message) {"info about our next Tenderlove x dislocated disco party coming soon with very special guests, its been a while <3\nhttp://www.youtube.com/watch?v=okLBcIaVHIA"}

    it "extracts message" do
      expect(post.message).to eq message
    end

    it "extracts picture" do
      expect(post.picture).to eq raw_post["picture"]
    end

    it "extracts id" do
      expect(post.post_id).to eq raw_post["id"]
    end

    it "extracts updated time" do
      expect(post.updated_time).to eq raw_post["updated_time"]
    end

  end

  context "saving new posts to the database" do
    before {PostsFetcher.check_for_dublications_and_save_posts(posts, author)}
    let(:post) {build :post, author: author}

    it "saves all posts to the db" do
      expect(author.posts.count).to eq amount_of_posts
    end

    it "doesn't save posts twice" do
      posts << post
      PostsFetcher.check_for_dublications_and_save_posts(posts, author)
      expect(author.posts.count).to eq amount_of_posts+1
    end

  end

  # context "integration tests (Hitting the network!)" do
  #   it "fetches posts for a given author and saves them to the db" do
  #     pending "this test hits the network"
  #     PostsFetcher.fetch_and_save_author_posts(author)
  #     expect(author.posts.count).to be > 10
  #   end
  # end
end