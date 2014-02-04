Dir["#{Rails.root}/app/workers/*.rb"].each { |file| require file }

Resque.schedule = YAML.load_file(Rails.root.join('config', 'rescue_schedule.yml'))