require './config/env'
Sequel.extension :migration

namespace :db do
  desc 'Prints current schema version.'
  task :version do
    version = if DB.tables.include?(:schema_info)
                DB[:schema_info].first[:version]
              end || 0

    puts "Schema Version: #{version}."
  end

  desc 'Perform migration up to latest migration available.'
  task :migrate do
    Sequel::Migrator.run(DB, 'db/migrations')
    Rake::Task['db:version'].execute
  end

  namespace :migrate do
    desc 'Display migration status.'
    task :status do
      if Sequel::Migrator.is_current?(DB, 'db/migrations')
        puts 'Up to date'
      else
        puts 'Not up to date'
      end
    end
  end

  desc 'Load database with demo data.'
  task :seed do
    require_relative('db/seed')
    puts 'Seed data loaded'
  end

  desc 'Perform rollback to specified target or full rollback as default.'
  task :rollback, :target do |_task, args|
    args.with_defaults(target: 0)

    Sequel::Migrator.run(DB, 'db/migrations', target: args[:target].to_i)
    Rake::Task['db:version'].execute
  end

  desc 'Perform migration reset (full rollback and migration).'
  task :reset do
    Sequel::Migrator.run(DB, 'db/migrations', target: 0)
    Sequel::Migrator.run(DB, 'db/migrations')
    Rake::Task['db:version'].execute
  end
end

namespace :assets do
  desc 'Webpack precompile'
  task :precompile do
    system('npm install')
    system('webpack')
  end
end

if (ENV['RACK_ENV'] == 'test') || (ENV['RACK_ENV'] == 'development')
  require 'rubocop/rake_task'

  namespace :ci do
    desc 'Run rubocop'
    RuboCop::RakeTask.new(:rubocop) do |t|
      t.fail_on_error = true
      t.verbose = false
      t.formatters = ['RuboCop::Formatter::SimpleTextFormatter']
      t.options = ['-D']
    end

    desc 'Check Rubycritic coverage'
    task :rubycritic do
      score_limit = 85
      rate_limit = 'B'
      paths = ['./app/models', './app/api', './app/controllers', './app/views', './config']
      skip_paths = ['./app/routes']
      puts "Cheking these directories #{paths}"
      puts "Only to note: Skipping these directories #{skip_paths}"
      files = Rubycritic.create(mode: :ci, format: :json, paths: paths).critique
      rating = files.map { |file| file.rating.to_s }.max
      score = files
              .reduce([]) { |memo, file| memo + file.smells }
              .map { |smell| smell.score || 0 }
              .max
      puts "RubyCritic Maximum score: #{score}, Minimum rating: #{rating}"
      fail("Failed because of score limit #{score_limit}") if score.to_i > score_limit
      fail("Failed because of rating limit #{rate_limit}") if rating > rate_limit
      puts 'Rubycritic all well'
    end

    desc 'Run things for ci'
    task :build do
      puts "\033[34mRunning rubocop:\033[0m"
      Rake::Task['ci:rubocop'].invoke
      puts "\033[34mRunning rubycritic:\033[0m"
      Rake::Task['ci:rubycritic'].invoke
    end
  end
end
