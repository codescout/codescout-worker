require "spec_helper"

describe Codescout::Worker do
  describe "sidekiq options" do
    let(:options) { described_class.sidekiq_options_hash }

    it "does not retry" do
      expect(options["retry"]).to eq false
    end

    it "specifies the queue name" do
      expect(options["queue"]).to eq "builds"
    end
  end

  describe "#perform" do
    let(:build)  { double }
    let(:worker) { described_class.new }

    before do
      allow(build).to receive(:run)
      allow(Codescout::Worker::Build).to receive(:new) { build }

      worker.perform("token")
    end

    it "executes the build" do
      expect(Codescout::Worker::Build).to have_received(:new).with("token")
      expect(build).to have_received(:run)
    end
  end
end