require 'active_record'

Dir.glob("models/*.rb").each do |file|
  require_relative file
end

ActiveRecord::Base.establish_connection(YAML.load_file('./config/database.yml')['development'])
