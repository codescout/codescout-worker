module Codescout
  class Worker
    include Sidekiq::Worker

    sidekiq_options(
      backtrace: true,
      retry: false,
      queue: "builds"
    )

    def perform(push_token)
      # TODO
    end
  end
end