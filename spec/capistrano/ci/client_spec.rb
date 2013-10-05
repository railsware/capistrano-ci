require 'spec_helper'

class CIConfig < Hash
  alias_method :exists?, :key?
end

describe Capistrano::CI::Client do
  let(:config) do
    config = CIConfig.new
    config[:ci_client] = ci_client
    config[:ci_repository] = "rails/rails"
    config
  end

  let(:client){ described_class.new(config) }

  describe "#state" do

    subject{ client.state("master") }

    context "when travis" do
      let(:ci_client){ "travis" }
      let(:travis_client){ double(state: "passed") }

      before do
        client.stub(:client).and_return(travis_client)
      end

      it{ should == "passed" }
    end

    context "when unsupported" do
      let(:ci_client){ "unsupported" }

      it{ ->{ subject }.should raise_error(Capistrano::CI::Client::NotFound) }
    end
  end

  describe "#passed?" do
    subject{ client.passed?("master") }

    context "when travis" do
      let(:ci_client){ "travis" }
      let(:travis_client){ double(state: "passed") }

      before do
        Capistrano::CI::Clients::Travis.should_receive(:new).with("rails/rails").and_return(travis_client)
      end

      it{ should be_true }
    end

    context "when unsupported" do
      let(:ci_client){ "unsupported" }

      it{ ->{ subject }.should raise_error(Capistrano::CI::Client::NotFound) }
    end
  end
end