require 'spec_helper'

describe Capistrano::CI::Clients::TravisPro, :vcr do
  let(:client){ described_class.new(ci_repository: "rails-private", ci_access_token: "secret_token") }

  describe "#passed?" do
    subject{ client.passed?(branch_name) }

    context "when passed" do
      let(:branch_name){ "master" }

      it{ should == true }
    end

    context "when not passed" do
      let(:branch_name){ "failed-branch" }

      it{ should == false }
    end
  end

  describe "#state" do

    subject{ client.state(branch_name) }

    context "when passed" do
      let(:branch_name){ "master" }

      it{ should == "passed" }
    end

    context "when not passed" do
      let(:branch_name){ "events-framework" }

      it{ should == "started" }
    end

    context "when repository was not found" do
      let(:client){ described_class.new(ci_repository: "rails/some_strange_repo", ci_access_token: "secret_token") }

      let(:branch_name){ "master" }

      it{ expect{ subject }.to raise_error(Capistrano::CI::Clients::ResponseError) }
    end
  end
end