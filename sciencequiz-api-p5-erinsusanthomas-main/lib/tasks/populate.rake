namespace :db do
  desc 'Erase and fill database'
  # creating a rake task within db namespace called 'populate'
  # executing 'rake db:populate' will cause this script to run
  task :populate => :environment do
    require 'factory_bot_rails'
    require './lib/tasks/populator'
    include Populator

    # Step 0: Reset of the databases (restart from scratch)
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:test:prepare'].invoke
    puts 'Reset the dev and test databases'

    # Step 1: Create things

  end
end