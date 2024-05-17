namespace :style do
  desc 'Run Ruby style checks'
  require 'cookstyle'
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new(:ruby) do |task|
    task.options << "--config=#{__dir__}/.rubocop.yml"
    task.options << '--display-cop-names'
    task.options << '--extra-details'
    task.options << '--display-style-guide'
  end
end

desc 'Run all style checks'
task 'style:all' => ['style:ruby']

require 'kitchen/rake_tasks'
Kitchen::RakeTasks.new

task default: %w(kitchen:all style:all)
