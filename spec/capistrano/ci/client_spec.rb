require 'spec_helper'

class CIConfig < Hash
  alias_method :exists?, :key?
end

describe Capistrano::CI::Client do
  describe "#state" do
    let(:client){ described_class.new(CIConfig.new(ci_client: ci_client)) }

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
    let(:client){ described_class.new(CIConfig.new(ci_client: ci_client)) }

    subject{ client.passed?("master") }

    context "when travis" do
      let(:ci_client){ "travis" }
      let(:travis_client){ double(state: "passed") }

      before do
        client.stub(:client).and_return(travis_client)
      end

      it{ should be_true }
    end

    context "when unsupported" do
      let(:ci_client){ "unsupported" }

      it{ ->{ subject }.should raise_error(Capistrano::CI::Client::NotFound) }
    end
  end
end