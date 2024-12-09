# require 'sidekiq-scheduler'

# Sidekiq.configure_server do |config|
#   # Load the schedule file when Sidekiq starts
#   config.on(:startup) do
#     Sidekiq.schedule = YAML.load_file(File.expand_path('../../sidekiq_schedule.yml', __FILE__))
#     Sidekiq::Scheduler.reload_schedule!
#   end
# end

# Sidekiq.configure_client do |config|
#   # Client configuration can go here (optional)
# end

:queues:
  - default
