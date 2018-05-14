# Load the Rails application.
require_relative 'application'

env_file = File.join(Rails.root, 'config', 'env.yml')
YAML.load(File.open(env_file)).each do |key, value|
	ENV[key.to_s] = value
end if File.exists?(env_file)

# Initialize the Rails application.
Rails.application.initialize!
