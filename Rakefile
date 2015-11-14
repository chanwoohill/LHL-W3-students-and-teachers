require './app_config'
require 'rspec/core/rake_task'
require 'active_record/schema_dumper'

desc 'create the database'
task 'db:create' do
  touch AppConfig::DATABASE_PATH
end

desc 'drop the database'
task 'db:drop' do
  rm_f AppConfig::DATABASE_PATH
end

desc 'dump the database'
task 'db:schema:dump' do
  AppConfig.establish_connection
  filename = File.absolute_path('db/schema.rb', File.dirname(__FILE__))
  File.open(filename, 'w:utf-8') do |file|
    ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, file)
  end
end

desc 'migrate the database (options: VERSION=x, VERBOSE=false, SCOPE=blog).'
task 'db:migrate' do
  AppConfig.establish_connection
  ActiveRecord::Migration.verbose = ENV['VERBOSE'] ? ENV['VERBOSE'] == 'true' : true
  ActiveRecord::Migrator.migrate(ActiveRecord::Migrator.migrations_paths, ENV['VERSION'] ? ENV['VERSION'].to_i : nil) do |migration|
    ENV['SCOPE'].blank? || (ENV['SCOPE'] == migration.scope)
  end
  Rake::Task['db:schema:dump'].invoke
end

desc 'rollback the database (options: VERSION=x, VERBOSE=false, STEPS=1).'
task 'db:rollback' do
  AppConfig.establish_connection
  ActiveRecord::Migration.verbose = ENV['VERBOSE'] ? ENV['VERBOSE'] == 'true' : true
  ActiveRecord::Migrator.rollback(ActiveRecord::Migrator.migrations_paths, ENV['STEPS'] ? ENV['STEPS'].to_i : 1)
  Rake::Task['db:schema:dump'].invoke
end

desc 'populate the test database with data'
task 'db:populate' do
  AppConfig.establish_connection
  StudentsImporter.new.import
  # Invoke your TeachersImporter here
  Teacher.create({name: "Jennifer Tigner", email: "jennifertigner@gmail.com", address: "905 E 15th Ave", phone: "111-1111"})
  Teacher.create({name: "Garrett Paul", email: "g_funk222@hotmail.com", address: "1005 McKenzie Ave", phone: "222-2222"})
  Teacher.create({name: "Rachel Tigner", email: "racheltigner@gmail.com", address: "1234 South Korea", phone: "333-3333"})
  Teacher.create({name: "Trevor Tigner", email: "trevortigner@gmail.com", address: "456 Ottawa", phone: "444-4444"})
  Teacher.create({name: "Laksh K", email: "laksh@gmail.com", address: "128 Launch Academy", phone: "555-5555"})
  Teacher.create({name: "Theo Theo", email: "theotheo@gmail.com", address: "Academy de Launch", phone: "666-6666"})
  Teacher.create({name: "Elly Longridge", email: "elly@hotmail.com", address: "905 E 15th Ave", phone: "777-7777"})
  Teacher.create({name: "Lauren Tee", email: "lauren@tee.com", address: "Somewhere in Vancouver", phone: "888-8888"})
  Teacher.create({name: "Reinhardt Rein", email: "reinhardt@school.com", address: "Launch Vancouver", phone: "999-9999"})
end

desc 'Retrieves the current schema version number'
task 'db:version' do
  AppConfig.establish_connection
  puts "Current version: #{ActiveRecord::Migrator.current_version}"
end

