require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

# Get rid of rspec background noise.
task(:spec).clear
RSpec::Core::RakeTask.new(:spec) do |t|
  t.verbose = false
end
task default: :spec

load 'tasks/mutant.rake'
