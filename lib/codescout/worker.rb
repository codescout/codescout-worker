require "codescout/worker/build"

module Codescout
  class Worker
    include Sidekiq::Worker

    sidekiq_options(
      backtrace: true,
      retry: false,
      queue: "builds"
    )

    def perform(push_token)
      Build.new(push_token).run
    end
  end
end