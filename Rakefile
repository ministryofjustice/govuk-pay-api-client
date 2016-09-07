APP_RAKEFILE = File.expand_path("../spec/dummy/Rakefile", __FILE__)
load 'rails/tasks/engine.rake'
load 'rails/tasks/statistics.rake'

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

# Get rid of rspec background noise.
task(:spec).clear
RSpec::Core::RakeTask.new(:spec) do |t|
  t.verbose = false
end
task default: :spec

load 'tasks/mutant.rake'
load 'tasks/rubocop.rake'
