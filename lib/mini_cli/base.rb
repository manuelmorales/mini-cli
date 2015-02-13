require 'thor'

module MiniCli
  # The base class to inherit from to provide the basic commands of a microservice
  class Base < Thor

    # Shows execution time to the end of the run
    def self.start
      require 'benchmark'
      bm = Benchmark.measure { |x| super }
      puts "\n#{bm.total.round(3)}s task run time"
    end

    desc 'test', 'Run the test suite'
    def test *args
      args = ['spec'] if args.empty?

      require 'spec/spec_helper'

      RSpec::Core::Runner.run(args)
    end

    desc 'console', 'Pry console with the app available'
    def console
      require'pry'
      Pry.start
    end

    desc 'auto [COMMAND]', 'Re-runs the given command on any file change'
    long_desc 'Re-runs the given command on any file change.' +
      " I. e. \"#{$0} auto test\" will run the tests on each file save."
    def auto *args
      require 'rerun'

      options = Rerun::Options.parse [
        '--background', 
        '--name', "./cli #{args.first}",
        '--signal', 'ABRT',
      ]

      Rerun::Runner.keep_running("./cli #{args.join " "}", options)
    end

    desc 'start', 'Starts the Puma and any other required thread'
    def start
      require 'puma/cli'
      Puma::CLI.new(puma_args).run
    end

    private

    def puma_args
      %w{-p 22000}
    end
  end
end

