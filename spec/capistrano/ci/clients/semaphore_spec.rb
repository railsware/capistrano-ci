require "spec_helper"

describe Capistrano::CI::Clients::Semaphore, :vcr do
  let(:client){ described_class.new(ci_repository: "rails/rails", ci_access_token: "access_token") }

  describe "#passed?" do
    subject{ client.passed?(branch_name) }

    context "when passed" do
      let(:branch_name){ "master" }

      it{ should == true }
    end

    context "when not passed" do
      let(:branch_name){ "feature" }

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
      let(:branch_name){ "feature" }

      it{ should == "failed" }
    end

    context "when branch was not found" do
      let(:branch_name){ "some_branch" }

      it{ expect{ subject }.to raise_error(Capistrano::CI::Clients::ResponseError) }
    end

    context "when repository was not found" do
      let(:client){ described_class.new(ci_repository: "rails/some_strange_repo", ci_access_token: "access_token") }

      let(:branch_name){ "master" }

      it{ expect{ subject }.to raise_error(Capistrano::CI::Clients::ResponseError) }
    end
  end

end