require 'active_record'
require 'active_record/fixtures'

namespace :db do
  DATA_DIRECTORY = "#{RAILS_ROOT}/lib/tasks/sample_data"
  namespace :sample_data do
    TABLES = %w(users)
    MIN_USER_ID = 1000

    desc "Load sample data"
    task :load => :environment do |t|
      class_name = nil
      TABLES.each do |table_name|
        fixture = Fixtures.new(ActiveRecord::Base.connection,
                               table_name, class_name,
                               File.join(DATA_DIRECTORY, table_name.to_s))
        fixture.insert_fixtures
        puts "Loaded data #{table_name}"
    end
  end

    desc "remove sample data"
    task :delete => :environment do |t|
      User.delete_all("id >= #{MIN_USER_ID}")
    end
end
end

  
