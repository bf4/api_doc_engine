# frozen_string_literal: true

begin
  require "rubocop"
  require "rubocop/rake_task"
rescue LoadError # rubocop:disable Lint/HandleExceptions
else
  Rake::Task[:rubocop].clear if Rake::Task.task_defined?(:rubocop)
  patterns = [
    'Gemfile',
    'Rakefile',
    'apps/**/Gemfile',
    'apps/**/Rakefile',
    'apps/**/*.{rb,rake,gemspec}',
    'lib/**/*.{rb,rake}',
    'config/**/*.rb',
    'app/**/*.rb',
    'spec/**/*.rb'
  ]
  desc 'Execute rubocop'
  RuboCop::RakeTask.new(:rubocop) do |task|
    task.formatters = ['progress']
    task.patterns = patterns
    task.fail_on_error = true
  end

  namespace :rubocop do
    desc 'Auto-gen rubocop config'
    task :auto_gen_config do
      options = ['--auto-gen-config'].concat patterns
      require 'benchmark'
      result = 0
      cli = RuboCop::CLI.new
      time = Benchmark.realtime do
        result = cli.run(options)
      end
      puts "Finished in #{time} seconds" if cli.options[:debug]
      abort('RuboCop failed!') if result.nonzero?
    end
  end
end
