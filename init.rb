$LOAD_PATH << "./lib"

require "bundler/setup"
require "dotenv"
require "sidekiq"
require "codescout/worker"

Dotenv.load