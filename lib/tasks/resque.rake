require 'resque/tasks'
require 'resque_scheduler/tasks'
require 'resque/pool/tasks'

task "resque:setup" => :environment 

task 'resque:pool:setup' do
  Resque::Pool.after_prefork do |job|
    Resque.redis.client.reconnect
  end
end

namespace :resque do
  task :setup do
    require 'resque'
    require 'resque_scheduler'
    Resque.redis = 'localhost:6379'
    Resque.schedule = YAML.load_file(Rails.root.join('config', 'rescue_schedule.yml'))
  end
end