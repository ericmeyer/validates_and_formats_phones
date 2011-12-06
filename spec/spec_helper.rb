require "rubygems"

gem 'activerecord'
require "active_record"

gem 'logger'
require "logger"

plugin_spec_dir = File.dirname(__FILE__)
ActiveRecord::Base.logger = Logger.new(plugin_spec_dir + "/debug.log")

databases = YAML::load(IO.read(plugin_spec_dir + "/db/database.yml"))

ActiveRecord::Base.establish_connection(databases[ENV["DB"] || "sqlite3"])
load(File.join(plugin_spec_dir, "db", "schema.rb"))
require "validates_and_formats_phones"

class ActiveRecord::Base
  include ValidatesAndFormatsPhones
end