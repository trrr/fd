class PostsFetcher
  @queue = :fetcher_queue

  def self.perform(id)
    author = Author.find(id)
    fetch_and_save_author_posts(author)
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
    posts = []
    raw_posts.each do |raw_post| 
      post = extract_post_from_raw_post(raw_post)
      posts << post unless post[:message] == nil
    end
    posts
  end

  def self.extract_post_from_raw_post(data)
    post = Post.new
    post.post_id = data['id'].to_s
    post.message = data['message']
    post.updated_time = data['updated_time']
    post.picture = data['picture']
    return post
  end

  def self.check_for_dublications_and_save_posts(posts, author)
    author.posts = (author.posts + posts).uniq
  end


  def self.fb_api
    @oauth = Koala::Facebook::OAuth.new(ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET'])
    Koala::Facebook::API.new(@oauth.get_app_access_token)
  end

end
