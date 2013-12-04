require 'spec_helper'

class CIConfig < Hash
  alias_method :exists?, :key?
end

describe Capistrano::CI::Client do
  let(:config) do
    config = CIConfig.new
    config[:ci_client] = ci_client
    config[:ci_repository] = "rails/rails"
    config[:ci_access_token] = "token"
    config
  end

  let(:client){ described_class.new(config) }

  describe ".register" do
    before{ described_class.register "new_client", Object, [:ci_new_setting] }

    after do
      described_class.clients.delete("new_client")
      described_class.settings.delete(:ci_new_setting)
    end

    it{ expect(described_class.clients["new_client"]).to eq({ client_class: Object, attributes: [:ci_new_setting] }) }
    it{ expect(described_class.settings).to include(:ci_new_setting) }
  end

  describe ".clients" do
    subject{ described_class.clients }

    it{ should have(4).items }
  end

  describe "#state" do

    subject{ client.state("master") }

    context "when travis" do
      let(:client_class){ Capistrano::CI::Clients::Travis }
      let(:ci_client){ "travis" }
      let(:travis_client){ double(state: "passed") }

      before{ expect(client_class).to receive(:new).with(ci_repository: "rails/rails").and_return(travis_client) }

      it{ should == "passed" }
    end

    context "when circle" do
      let(:client_class){ Capistrano::CI::Clients::Circle }
      let(:ci_client){ "circle" }
      let(:travis_client){ double(state: "passed") }

      before{ expect(client_class).to receive(:new).with(ci_repository: "rails/rails", ci_access_token: "token").and_return(travis_client) }

      it{ should == "passed" }
    end

    context "when semaphore" do
      let(:client_class){ Capistrano::CI::Clients::Semaphore }

      let(:ci_client){ "semaphore" }
      let(:semaphore_client){ double(state: "passed") }

      before{ expect(client_class).to receive(:new).with(ci_repository: "rails/rails", ci_access_token: "token").and_return(semaphore_client) }

      it{ should == "passed" }
    end

    context "when travis pro" do
      let(:client_class){ Capistrano::CI::Clients::TravisPro }

      let(:ci_client){ "travis_pro" }
      let(:travis_client){ double(state: "passed") }

      before{ expect(client_class).to receive(:new).with(ci_repository: "rails/rails", ci_access_token: "token").and_return(travis_client) }

      it{ should == "passed" }
    end

    context "when unsupported" do
      let(:ci_client){ "unsupported" }

      it{ expect{ subject }.to raise_error(Capistrano::CI::Client::NotFound) }
    end
  end

  describe "#passed?" do
    subject{ client.passed?("master") }

    context "when travis" do
      let(:client_class){ Capistrano::CI::Clients::Travis }
      let(:ci_client){ "travis" }
      let(:travis_client){ double(passed?: true) }

      before{ expect(client_class).to receive(:new).with(ci_repository: "rails/rails").and_return(travis_client) }

      it{ should == true }
    end

    context "when circle" do
      let(:client_class){ Capistrano::CI::Clients::Circle }
      let(:ci_client){ "circle" }
      let(:travis_client){ double(passed?: true) }

      before{ expect(client_class).to receive(:new).with(ci_repository: "rails/rails", ci_access_token: "token").and_return(travis_client) }

      it{ should == true }
    end

    context "when semaphore" do
      let(:client_class){ Capistrano::CI::Clients::Semaphore }

      let(:ci_client){ "semaphore" }
      let(:semaphore_client){ double(passed?: true) }

      before{ expect(client_class).to receive(:new).with(ci_repository: "rails/rails", ci_access_token: "token").and_return(semaphore_client) }

      it{ should == true }
    end

    context "when travis pro" do
      let(:client_class){ Capistrano::CI::Clients::TravisPro }
      let(:ci_client){ "travis_pro" }
      let(:travis_client){ double(passed?: true) }

      before{ expect(client_class).to receive(:new).with(ci_repository: "rails/rails", ci_access_token: "token").and_return(travis_client) }

      it{ should == true }
    end

    context "when unsupported" do
      let(:ci_client){ "unsupported" }

      it{ expect{ subject }.to raise_error(Capistrano::CI::Client::NotFound) }
    end
  end
end