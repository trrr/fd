require 'spec_helper'

describe Post do
  it {should belong_to(:author) }  

  let(:category) {create :category}
  let(:author) {create :author, category: category}

  let(:data) {JSON.parse(File.read("spec/response.json"))}
  let(:posts) {PostsFetcher.serialize_posts(data)}

  before { PostsFetcher.check_for_dublications_and_save_posts(posts, author) }

  it "sets category id" do
    expect(author.posts.first.category_id).not_to be_nil
  end

  it "orders by updated_time DESC" do
    expect(Post.pluck(:post_id).first).to eq "36922302396_10151862237292397"
    expect(Post.pluck(:post_id).last).to eq "36922302396_10151852873192397"
  end


  context "retrieving posts" do
    let(:author2) {create :author, profile: 'lg', category: category2}
    let(:category2) {create :category}
    let(:post) {create :post, author: author2}
    let(:categories_ids) { nil }
    before { post }

    context "scopes" do
      let(:amount_of_attributes_for_api) {6}
      let(:amount_of_all_posts) {19}

      it "api_data gives back only needed data" do
        expect(Post.api_data.find(post.id).attributes.length).to eq amount_of_attributes_for_api
      end

      context "posted_at" do
        it "retrieves posts by category" do
          expect(Post.category_in(category2.id).first).to eq post
        end

        it "retrieves posts from all categories if none given" do
          expect(Post.category_in(nil).count).to eq amount_of_all_posts
        end
      end

      context "posted_at" do
        it "returns all posts if no arguments given" do
          expect(Post.posted_at(nil, nil).count).to eq amount_of_all_posts
        end

        it "returns previous posts" do
          expect(Post.posted_at( '<', "2014-02-06 19:22:53" ).first.post_id).to eq "36922302396_10151860655437397"
          expect(Post.posted_at( '<', "2014-02-06 19:22:53" ).last.post_id).to eq "113984671987671_10151994226948621"
        end

        it "returns next posts" do
          expect(Post.posted_at( '>', "2014-02-04 11:35:29").first.post_id).to eq "36922302396_10151862237292397"
          expect(Post.posted_at( '>', "2014-02-04 11:35:29").last.post_id).to eq "36922302396_10151855388582397"
        end
      end

    end

    context "get_posts_by_params" do
      it "returns given amount of posts" do
        expect(Post.get_posts_by_params(categories_ids, 10).count).to eq 10
      end

      it "returns posts by category" do
        expect(Post.get_posts_by_params(category2.id).first).to eq post
      end

      describe "it works altogether" do
        let(:previous_five) {["36922302396_10151860655437397", 
          "36922302396_10151856899407397", 
          "36922302396_10151851262957397", 
          "36922302396_10151852781652397", 
          "36922302396_10151854664477397"]}

        it "returns previous five posts from the first category" do
          expect(Post.get_posts_by_params(category.id, 5, "2014-02-06 19:22:53", '<').pluck(:post_id)).to eq previous_five
        end

      end
    end
  end
end
