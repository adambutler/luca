namespace :dbt do
  desc "Pull data from remote PostgreSQL server to local development database"
  task pull_production: :environment do
    # Ensure RAILS_ENV is development
    unless Rails.env.development?
      raise StandardError.new("RAILS_ENV must be development for this task")
    end

    # Drop and recreate local development database
    puts "Dropping and recreating development database..."
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke

    # Pull data from remote PostgreSQL server
    puts "Pulling data from remote PostgreSQL server..."

    dbname = [
      "postgresql://",
      "#{DbtConfig.username}:#{DbtConfig.password}",
      "@#{DbtConfig.host}",
      "/#{DbtConfig.database_name}",
    ].join("")
    
    # Execute the pg_dump command to dump the remote database data into a file
    dump_file = "#{Rails.root}/tmp/#{DbtConfig.database_name}-#{Time.now.to_i}.sql"
    `pg_dump -Fc --no-acl --no-owner --dbname=#{dbname} > #{dump_file}`

    puts "Dump file created: #{dump_file}"
    puts "Loading data into local development database..."

    # Load the dumped data into the local development database
    puts `pg_restore --verbose --clean --no-acl --no-owner -d #{Rails.configuration.database_configuration[Rails.env]["database"]} #{dump_file}`

    puts "Setting the database environment..."
    `bin/rails db:environment:set RAILS_ENV=development`

    puts "Cleaning up dump file..."

    # Clean up the dump file
    File.delete(dump_file)

    puts "Data successfully pulled from remote PostgreSQL server."
  end
end
