require 'active_record'

class SeedLoader
  def load_seed
    nil
  end
end

include ActiveRecord::Tasks

DatabaseTasks.database_configuration = YAML.load_file('./config/database.yml')
DatabaseTasks.db_dir = 'db'
DatabaseTasks.migrations_paths = 'db/migrate'
DatabaseTasks.root = Rake.application.original_dir
DatabaseTasks.env = 'development'
DatabaseTasks.seed_loader = SeedLoader.new

load 'active_record/railties/databases.rake'
