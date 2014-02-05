class PostsFetcherScheduler
  @queue = :scheduler_queue

  def self.perform
    Author.all.each {|author| Resque.enqueue(PostsFetcher, author.id)}
  end
end
