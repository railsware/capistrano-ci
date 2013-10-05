require 'spec_helper'

describe Capistrano::CI::Clients::TravisPro, :vcr do
  let(:client){ described_class.new("rails/rails-private", "secret_token") }

  describe "#passed?" do
    subject{ client.passed?(branch_name) }

    context "when passed" do
      let(:branch_name){ "master" }

      it{ should be_true }
    end

    context "when failed" do
      let(:branch_name){ "events-framework" }

      it{ should be_false }
    end
  end

  describe "#state" do

    subject{ client.state(branch_name) }

    context "when passed" do
      let(:branch_name){ "master" }

      it{ should == "passed" }
    end

    context "when failed" do
      let(:branch_name){ "events-framework" }

      it{ should == "failed" }
    end

    context "when repository was not found" do
      let(:client){ described_class.new("rails/some_strange_repo", "secret_token") }

      let(:branch_name){ "master" }

      it{ -> { subject }.should raise_error(Travis::Client::NotFound) }
    end
  end
end