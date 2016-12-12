require 'rake/testtask'

# Tasks
namespace :foreman_http_proxies do
  namespace :example do
    desc 'Example Task'
    task task: :environment do
      # Task goes here
    end
  end
end

# Tests
namespace :test do
  desc 'Test ForemanHttpProxies'
  Rake::TestTask.new(:foreman_http_proxies) do |t|
    test_dir = File.join(File.dirname(__FILE__), '../..', 'test')
    t.libs << ['test', test_dir]
    t.pattern = "#{test_dir}/**/*_test.rb"
    t.verbose = true
    t.warning = false
  end
end

namespace :foreman_http_proxies do
  task :rubocop do
    begin
      require 'rubocop/rake_task'
      RuboCop::RakeTask.new(:rubocop_foreman_http_proxies) do |task|
        task.patterns = ["#{ForemanHttpProxies::Engine.root}/app/**/*.rb",
                         "#{ForemanHttpProxies::Engine.root}/lib/**/*.rb",
                         "#{ForemanHttpProxies::Engine.root}/test/**/*.rb"]
      end
    rescue
      puts 'Rubocop not loaded.'
    end

    Rake::Task['rubocop_foreman_http_proxies'].invoke
  end
end

Rake::Task[:test].enhance ['test:foreman_http_proxies']

load 'tasks/jenkins.rake'
if Rake::Task.task_defined?(:'jenkins:unit')
  Rake::Task['jenkins:unit'].enhance ['test:foreman_http_proxies', 'foreman_http_proxies:rubocop']
end
