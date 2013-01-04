if Rails.configuration.database_configuration[Rails.env]['database'] == ':memory:'
  puts "Loading the schema manually"
  load "#{Rails.root}/db/schema.rb"
end
