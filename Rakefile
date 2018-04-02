namespace :style do
  desc 'Run Ruby style checks'
  require 'cookstyle'
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new(:ruby) do |task|
    task.options << '--display-cop-names'
    task.options << '--extra-details'
    task.options << '--display-style-guide'
    task.options << '--force-exclusion'
  end

  desc 'Run Chef style checks'
  require 'foodcritic'
  FoodCritic::Rake::LintTask.new(:chef) do |task|
    task.options[:fail_tags] = ['any']
  end
end

desc 'Run all style checks'
task 'style:all' => ['style:ruby', 'style:chef']

if ENV['KITCHEN_PLATFORM']
  require 'kitchen/rake_tasks'
  Kitchen::RakeTasks.new
  task default: ['style:all', 'kitchen:all']
else
  task default: ['style:all']
end
