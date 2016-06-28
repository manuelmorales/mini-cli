require_relative '../spec_helper'

describe Base do
  let(:cli){ Base.new }
  before { allow(cli).to receive(:exit) }

  def do_run
    cli.invoke_command cli.class.all_commands[args.first], args[1..-1]
  end

  describe '#test' do
    let(:args) { %w{test} }

    it 'runs the RSpec suite' do
      expect(RSpec::Core::Runner).to receive(:run)
      do_run
    end

    describe 'with args' do
      let(:args) { %w{test random args} }

      it 'passes args to RSpec' do
        expect(RSpec::Core::Runner).to receive(:run).with(['random','args'])
        do_run
      end
    end

    it 'passes ["spec"] if no args are specified' do
      expect(RSpec::Core::Runner).to receive(:run).with(['spec'])
      do_run
    end

    it 'exits with the returned status code' do
      expect(RSpec::Core::Runner).to receive(:run).and_return 99
      expect(cli).to receive(:exit).with 99
      do_run
    end
  end

  describe '#console' do
    let(:args) { %w{console} }

    it 'runs pry' do
      expect(Pry).to receive(:start)
      do_run
    end
  end

  describe '#start' do
    before(:all){ require 'puma/cli' }
    let(:args) { %w{start} }

    it 'runs a Puma server' do
      a_puma = double('a puma')
      expect(Puma::CLI).to receive(:new).with(['-p', '22000']).and_return a_puma
      expect(a_puma).to receive(:run)
      do_run
    end
  end

  describe '#auto' do
    before(:all){ require 'rerun' }
    let(:args) { %w{auto sample command} }

    it 'launches rerun with the given command' do
      expect(Rerun::Runner).to receive(:keep_running) do |command, options|
        expect(command).to eq './cli sample command'
      end

      do_run
    end
  end

  describe '#rubocop' do
    before(:all){ require 'rubocop' }
    let(:args) { %w{rubocop some args} }

    it 'runs rubocop' do
      a_cop = double('rubocop')
      expect(RuboCop::CLI).to receive(:new).and_return a_cop
      expect(a_cop).to receive(:run).and_return 99
      expect(cli).to receive(:exit).with 99
      do_run
    end

    it 'passes the args' do
      a_cop = double('rubocop')
      expect(RuboCop::CLI).to receive(:new).and_return a_cop
      expect(a_cop).to receive(:run).with(['some', 'args'])
      do_run
    end
  end
end

