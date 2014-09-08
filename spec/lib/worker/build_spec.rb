require "spec_helper"

describe Codescout::Worker::Build do
  it "has a timeout" do
    expect(Codescout::Worker::Build::BUILD_TIMEOUT).to eq 300
  end

  describe "#run" do
    let(:build)     { described_class.new("token") }
    let(:container) { double }

    before :all do
      ENV["CODESCOUT_URL"] = "http://host"
      ENV["DOCKER_IMAGE"] = "codescout/codescout"
    end

    before do
      allow(Docker::Container).to receive(:create) { container }

      [:start, :attach, :wait, :kill, :delete].each do |action|
        allow(container).to receive(action)
      end

      build.run
    end

    it "creates a new container" do
      expect(Docker::Container).to have_received(:create).with(
        "name"  => "codescout-token",
        "Cmd"   => ["codescout-runner"],
        "Image" => "codescout/codescout",
        "Env"   => [
          "CODESCOUT_URL=http://host",
          "CODESCOUT_PUSH=token"
        ]
      )
    end

    it "starts execution" do
      expect(container).to have_received(:start)
    end

    it "waits until container is finished" do
      expect(container).to have_received(:wait).with(300)
    end

    it "kills the container" do
      expect(container).to have_received(:kill)
    end

    it "forcefully removes container" do
      expect(container).to have_received(:delete).with(force: true)
    end
  end
end