require 'resque/failure/redis'

Dir["#{Rails.root}/app/workers/*.rb"].each { |file| require file }