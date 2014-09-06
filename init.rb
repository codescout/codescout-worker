$LOAD_PATH << "./lib"

require "bundler/setup"
require "dotenv"
require "sidekiq"
require "codescout/worker"

def require_var(name)
  raise "Please define #{name}" if ENV[name].nil?
end

Dotenv.load

require_var("REDIS_URL")
require_var("CODESCOUT_URL")
require_var("DOCKER_HOST")
require_var("DOCKER_IMAGE")