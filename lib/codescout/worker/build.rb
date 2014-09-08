require "docker"
require "securerandom"

module Codescout
  class Worker
    class Build
      BUILD_TIMEOUT = 300 # 5 minutes

      def initialize(push_token)
        @push_token = push_token
      end

      def run
        container = create_container

        container.tap(&:start).attach do |stream, chunk|
          STDOUT.print("[#{stream}] #{chunk}")
        end

        container.wait(BUILD_TIMEOUT)
        container.kill
        container.delete(force: true)
      end

      private

      def create_container
        Docker::Container.create(
          "name"         => "codescout-#{@push_token}",
          "Cmd"          => ["codescout-runner"],
          "Image"        => image_name,
          "Env"          => env_vars,
        )
      end

      def image_name
        ENV["DOCKER_IMAGE"]
      end

      def env_vars
        [
          "CODESCOUT_URL=#{ENV["CODESCOUT_URL"]}",
          "CODESCOUT_PUSH=#{@push_token}"
        ]
      end
    end
  end
end