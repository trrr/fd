class PostsFetcher
  @queue = :fetcher_queue

  def self.perform(id)
    fetch_and_save_author_posts(Author.find(id))
  end

  def self.fetch_and_save_author_posts(author)
    raw_posts = fetch_posts(author)
    posts = serialize_posts(raw_posts)
    check_for_dublications_and_save_posts(posts, author)
  end

  def self.fetch_posts(author)
    fb_api.get_connections("#{author.profile}", 'posts')
  end

  def self.serialize_posts(raw_posts)
    raw_posts.reject {|post| post["message"] == nil}.map do |raw_post|
      extract_post_from_raw_post(raw_post)
    end
  end

  def self.extract_post_from_raw_post(data)
    Post.new do |p|
      p.post_id = data['id'].to_s
      p.message = data['message']
      p.updated_time = data['updated_time']
      p.picture = data['picture']
    end
  end

  def self.check_for_dublications_and_save_posts(posts, author)
    author.posts = (author.posts + posts).uniq {|post| post.post_id}
  end


  def self.fb_api
    @oauth = Koala::Facebook::OAuth.new(ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET'])
    Koala::Facebook::API.new(@oauth.get_app_access_token)
  end

end
