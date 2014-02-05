require 'spec_helper'

describe Post do
  it {should belong_to(:author) }
  it {Post.should order('updated_time DESC') }

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
    p = [post1, post3, post]
    p.each {|post| author.posts << post}
    expect(Post.all.map(&:post_id)).to eq p.map(&:post_id)
  end

  it "gives previous posts" do
    pending "TODO"
  end

  it "gives next posts" do
    pending "TODO"
  end
end
