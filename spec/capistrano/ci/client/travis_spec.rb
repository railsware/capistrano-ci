require 'spec_helper'

describe Capistrano::CI::Client::Travis, :vcr do
  describe "#passed?" do
    subject{ client.passed?("master") }

    context "when passed" do
      let(:client){ described_class.new("rails/rails") }

      it{ should be_true }
    end

    context "when failed" do
      let(:client){ described_class.new("railsware/zero_deploy") }

      it{ should be_false }
    end
  end

  describe "#state" do

    subject{ client.state("master") }


    context "when passed" do
      let(:client){ described_class.new("rails/rails") }

      it{ should == "passed" }
    end

    context "when failed" do
      let(:client){ described_class.new("railsware/zero_deploy") }

      it{ should == "failed" }
    end

    context "when repository was not found" do
      let(:client){ described_class.new("rails/some_strange_repo") }

      it{ -> { subject }.should raise_error(Travis::Client::NotFound) }
    end
  end
end