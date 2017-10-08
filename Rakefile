require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RuboCop::RakeTask.new(:rubocop) do |task|
  task.options = ['--display-cop-names']
end

RSpec::Core::RakeTask.new(:spec) do |task|
  task.rspec_opts = '--format documentation'
end

task default: %i[rubocop spec]
