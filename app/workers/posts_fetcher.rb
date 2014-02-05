class PostsFetcher
  @queue = :fetcher_queue

  # ALERT! In the current state this worker can run only as a single thread!
  # In order for this to run asyncronisly you'll have to
  # create another worker that will split authors by number of threads
  # and pass groups of authors to this worker.
  # And don't forget to reconfigure the resque scheduler!

  def self.perform
    Authors.all.each do |author|
      fetch_and_save_author_posts(author)
    end
  end

  def self.fetch_and_save_author_posts(author)
    raw_posts = fetch_posts(author)
    posts = serialize_posts(raw_posts)
    check_for_dublications_and_save_posts(posts, author)
  end

  def self.fetch_posts(author)
    fb_api.get_connections("#{author.profile}", 'posts')
  end

  def self.extract_post_from_raw_post(data)
    post = Post.new
    post.post_id = data['id'].to_s
    post.message = data['message']
    post.updated_time = data['updated_time']
    post.picture = data['picture']
    return post
  end

  # TODO: That crap needs serious refactoring!
  def self.serialize_posts(raw_posts)
    posts = []
    raw_posts.each do |raw_post| 
      post = extract_post_from_raw_post(raw_post)
      posts << post unless post[:message] == nil
    end
    posts
  end


  def self.check_for_dublications_and_save_posts(posts, author)
    existing_posts = author.posts.map(&:post_id)
    posts.each do |post|
      author.posts << post unless existing_posts.include?(post.post_id)
    end
  end


  def self.fb_api
    # For test sake
    ENV['FACEBOOK_APP_ID'] = "1419909291585700"
    ENV['FACEBOOK_APP_SECRET'] = "ff5c45bb0c190064ba21b3b9480beb14"

    @oauth = Koala::Facebook::OAuth.new(ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET'])
    Koala::Facebook::API.new(@oauth.get_app_access_token)
  end

end
