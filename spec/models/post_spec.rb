require 'spec_helper'

describe Post do
  it {should belong_to(:author) }  

  let(:category) {Category.create(name: "Tech")}
  let(:author) {Author.create(profile: "nokia", category_id: 1)}

  let(:data) {JSON.parse(File.read("spec/response.json"))}
  let(:posts) {PostsFetcher.serialize_posts(data)}
  before {PostsFetcher.check_for_dublications_and_save_posts(posts, author)}

  it "works" do
    pending "clean up and use fixtures!"
  end

  it "sets category id" do
    expect(author.posts.first.category_id).not_to be_nil
  end

  it "orders by updated_time DESC" do
    expect(Post.first.post_id).to eq "36922302396_10151862237292397"
    expect(Post.last.post_id).to eq "36922302396_10151852873192397"
  end

  context "retrieving posts" do
    let(:timepoint) {"2000-01-01T00:00:00.000Z"}
    let(:up_or_down) {'>'}
    let(:categories_ids) {1}
    let(:page) {1}
    let(:per_page) {10}
 
    it "returns given amount of posts" do
      expect(Post.get_posts_by_params(categories_ids, page, 5, timepoint, up_or_down).count).to eq 5
    end

    it "returns posts by category" do
      pending "add another category and test this case"
    end

    context "pagination" do
      let(:set_of_posts) {Post.get_posts_by_params(categories_ids, page, per_page, timepoint, up_or_down)}
      let(:next_page) {2}

      it "return same page" do
        expect(Post.get_posts_by_params(categories_ids, page, per_page, timepoint, up_or_down)).to eq set_of_posts
      end

      it "returns next page" do
        expect(Post.get_posts_by_params(categories_ids, next_page, per_page, timepoint, up_or_down)).not_to eq set_of_posts
      end
    end

    context "retrieving next/previous posts from post" do
      let(:second_page) {Post.get_posts_by_params(categories_ids, 2, per_page, timepoint, up_or_down).pluck(:post_id)}
      let(:first_page) {Post.get_posts_by_params(categories_ids, 1, per_page, timepoint, up_or_down).pluck(:post_id)}

      it "gives previous ten posts" do
        expect(Post.get_posts_by_params(categories_ids, page, per_page, "2014-02-06 19:22:53", '<').pluck(:post_id)).to eq second_page
      end

      it "gives next ten posts" do
        expect(Post.get_posts_by_params(categories_ids, page, per_page, "2014-02-04 11:35:29", '>').pluck(:post_id)).to eq first_page
      end
    end
  end
end
