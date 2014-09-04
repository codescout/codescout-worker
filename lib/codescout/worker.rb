require "docker"

module Codescout
  class Worker
    include Sidekiq::Worker

    sidekiq_options(
      backtrace: true,
      retry: false,
      queue: "builds"
    )

    def perform(push_token)
      image_name = "codescout"

      env_vars = [
        "CODESCOUT_URL=#{ENV["CODESCOUT_URL"]}",
        "CODESCOUT_PUSH=#{push_token}"
      ]

      container = Docker::Container.create(
        "name"         => "codescout-#{push_token}",
        "Cmd"          => ["codescout-runner"],
        "Image"        => image_name,
        "Env"          => env_vars,
      ) 

      container.tap(&:start).attach do |stream, chunk|
        STDOUT.puts("#{chunk}")
      end

      container.wait(120)
      container.delete(force: true)
    end
  end
end