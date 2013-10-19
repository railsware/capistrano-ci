require 'spec_helper'

describe Capistrano::CI::Clients::Travis, :vcr do
  describe "#passed?" do
    subject{ client.passed?("master") }

    context "when passed" do
      let(:client){ described_class.new(ci_repository: "rails/rails") }

      it{ should == true }
    end

    context "when failed" do
      let(:client){ described_class.new(ci_repository: "railsware/zero_deploy") }

      it{ should == false }
    end
  end

  describe "#state" do

    subject{ client.state("master") }


    context "when passed" do
      let(:client){ described_class.new(ci_repository: "rails/rails") }

      it{ should == "passed" }
    end

    context "when failed" do
      let(:client){ described_class.new(ci_repository: "railsware/zero_deploy") }

      it{ should == "failed" }
    end

    context "when repository was not found" do
      let(:client){ described_class.new(ci_repository: "rails/some_strange_repo") }

      it{ expect{ subject }.to raise_error(Capistrano::CI::Clients::ResponseError) }
    end
  end
end