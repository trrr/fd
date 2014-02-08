  class PostsFetcherScheduler
  @queue = :scheduler_queue

  def self.perform
    Author.pluck(:id).each {|author_id| Resque.enqueue(PostsFetcher, author_id)}
  end
end
