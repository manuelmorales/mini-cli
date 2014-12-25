require 'thor'

module MiniCli
  class Base < Thor
    def self.start
      require 'benchmark'
      bm = Benchmark.measure { |x| super }
      puts "\n#{bm.total.round(3)} s execution time\n\n"
    end

    desc 'test', 'run the rspec tests'
    def test *args
      args = ['spec'] if args.empty?

      require_relative '../../spec/spec_helper'

      RSpec::Core::Runner.run(args)
    end

    desc 'console', 'pry console'
    def console
      invoke :environment
      require'pry'
      Pry.start
    end

    desc 'auto [COMMAND]', 're-runs the given command on any file change'
    def auto *args
      require 'rerun'

      options = Rerun::Options.parse [
        '--background', 
        '--name', "./cli #{args.first}",
        '--signal', 'ABRT',
      ]

      Rerun::Runner.keep_running("./cli #{args.join " "}", options)
    end

    desc 'start', 'runs the HTTP server'
    def start
      invoke :environment
      require 'puma/cli'
      Puma::CLI.new([]).run
    end

    desc 'environment', 'loads environment.rb'
    def environment
      # Override requiring the right libs. Example:
      # require_relative'../../config/environment'
    end
  end
end

