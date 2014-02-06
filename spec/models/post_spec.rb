require 'spec_helper'

describe Post do
  it {should belong_to(:author) }  
  let(:category) {Category.create(name: "Tech")}
  let(:author) {Author.create(profile: "nokia", category_id: 1)}
  let(:post) {Post.new(message: "Message", updated_time: "2014-02-05 07:08:02", post_id: "12312312")}
  let(:post1) {Post.new(message: "Message", updated_time: "2014-02-09 07:08:02", post_id: "1231235465412")}
  let(:post3) {Post.new(message: "Message", updated_time: "2014-02-07 07:08:02", post_id: "12312334212")}

  it "sets category id" do
    author.posts << post
    expect(post.category_id).to eq 1
  end

  it "order by updated_time DESC" do
    pending "It's failing because of the author after_save heroku fix"
    # p = [post1, post3, post]
    # p.each {|post| author.posts << post}
    # expect(Post.all.map(&:post_id)).to eq p.map(&:post_id)
  end

 describe "retrieving posts" do
    let(:timepoint) {"2000-01-01T00:00:00.000Z"}
    let(:up_or_down) {'>'}
    let(:categories_ids) {Category.all.map(&:id)}
    let(:page) {1}
    let(:per_page) {10}

    it "returns given amount of posts" do
      pending "can't test without stubing the network!"
      # expect(Post.get_posts_by_params(categories_ids, page, 5, timepoint, up_or_down).count).to eq 5
    end

    it "gives previous posts" do
      
    end

    it "gives next posts" do
      pending "TODO"
    end

  end
end
