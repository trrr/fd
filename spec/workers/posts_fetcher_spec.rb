require 'spec_helper'
require 'json'

describe PostsFetcher do
  let(:data) {JSON.parse(File.read("spec/response.json"))}
  let(:category) {Category.create(name: "Tech")}
  let(:posts) {PostsFetcher.serialize_posts(data)}
  let(:author) {Author.new(profile: "nokia")}
  let(:amount_of_posts) {18}
  before {category.authors << author}


  it "" do
    pending "TODO: clean up and use factories!"
  end

  context "fetching posts from facebook (hitting the network here!)" do

    before {Author.any_instance.stub(:profile).and_return('nokia')}

    it "fetches posts of given author from facebook" do
      pending "uncomment when needed (you'll have to have the right facebook tokens)"
      # expect(PostsFetcher.fetch_posts(Author.new).count).to be > 5
    end
  end

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

    it "saves all posts to the db" do
      expect(author.posts.count).to eq amount_of_posts
    end

    it "doesn't save posts twice" do
      PostsFetcher.check_for_dublications_and_save_posts(posts, author)
      expect(author.posts.count).to eq amount_of_posts
    end
  end

  context "integration tests (Hitting the network!)" do
    it "fetches and saves posts for given author" do
      pending "uncomment it when needed"
      # PostsFetcher.fetch_and_save_author_posts(author)
      # expect(author.posts.count).to be > 5
    end

  end
end
    

#To save response do: File.open('spec/response.json', 'w'){ |f| f << data.to_json }
