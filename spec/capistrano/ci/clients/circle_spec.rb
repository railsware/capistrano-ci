require 'spec_helper'

describe Capistrano::CI::Clients::Circle, :vcr do
  let(:client){ described_class.new ci_repository: "rails/rails", ci_access_token: "api_token" }

  describe "#passed?" do
    subject{ client.passed?(branch_name) }

    context "when passed" do
      let(:branch_name){ "master" }

      it{ should == true }
    end

    context "when not passed" do
      let(:branch_name){ "development" }

      it{ should == false }
    end
  end

  describe "#state" do
    let(:branch_name){ "master" }

    subject{ client.state(branch_name) }

    context "when passed" do
      it{ should == "success" }
    end

    context "when not passed" do
      let(:branch_name){ "development" }

      it{ should == "failed" }
    end

    context "when branch was not found" do
      let(:branch_name){ "some_branch" }

      it{ expect{ subject }.to raise_error(Capistrano::CI::Clients::ResponseError) }
    end

    context "when repository was not found" do
      let(:client){ described_class.new ci_repository: "sendgridlabs/loaderio-web-blabla", ci_access_token: "api_token" }

      it{ expect{ subject }.to raise_error(Capistrano::CI::Clients::ResponseError) }
    end
  end
end