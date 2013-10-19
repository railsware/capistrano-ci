require 'spec_helper'

describe Capistrano::CI::Clients::Base do
  describe "#passed?" do
    subject{ described_class.new.passed?("master") }

    it{ expect{ subject }.to raise_error(NotImplementedError) }
  end

  describe "#state" do
    subject{ described_class.new.state("master") }

    it{ expect{ subject }.to raise_error(NotImplementedError) }
  end
end