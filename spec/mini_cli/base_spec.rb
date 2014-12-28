require_relative '../spec_helper'

describe Base do
  let(:cli){ Base.new }

  describe '#test' do
    it 'runs the RSpec suite' do
      expect(RSpec::Core::Runner).to receive(:run)
      cli.test
    end

    it 'passes args to RSpec' do
      expect(RSpec::Core::Runner).to receive(:run).with(['random','args'])
      cli.test('random','args')
    end

    it 'passes ["spec"] if no args are specified' do
      expect(RSpec::Core::Runner).to receive(:run).with(['spec'])
      cli.test
    end
  end

  describe '#console' do
    it 'runs pry' do
      expect(Pry).to receive(:start)
      cli.console
    end
  end

  describe '#start' do
    before(:all){ require 'puma/cli' }

    it 'runs a Puma server' do
      a_puma = double('a puma')
      expect(Puma::CLI).to receive(:new).with(['-p', '22000']).and_return a_puma
      expect(a_puma).to receive(:run)
      cli.start
    end
  end

  describe '#auto' do
    before(:all){ require 'rerun' }

    it 'launches rerun with the given command' do
      expect(Rerun::Runner).to receive(:keep_running) do |command, options|
        expect(command).to eq './cli sample command'
      end
      cli.auto 'sample command'
    end
  end
end

