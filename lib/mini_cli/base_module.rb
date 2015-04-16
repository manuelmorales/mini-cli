module MiniCli
  # Provides class methods for individual definition of ready-made commands
  module BaseModule
    module ClassMethods
      def add_console_pry
        desc 'console', 'Pry console with the app available'
        define_method :console do
          require'pry'
          Pry.start
        end
      end

      def add_test_rspec
        desc 'test', 'Run the test suite'
        define_method :test do |*args|
          args = ['spec'] if args.empty?
          require 'rspec'
          RSpec::Core::Runner.run(args)
        end
      end

      def add_auto_rerun
        desc 'auto [COMMAND]', 'Re-runs the given command on any file change'
        long_desc 'Re-runs the given command on any file change.' +
          " I. e. \"#{$0} auto test\" will run the tests on each file save."
        define_method :auto do |*args|
          require 'rerun'

          options = Rerun::Options.parse [
            '--background', 
            '--name', "./cli #{args.first}",
            '--signal', 'ABRT',
            '--ignore', 'coverage/*',
          ]

          Rerun::Runner.keep_running("./cli #{args.join " "}", options)
        end
      end

      def add_start_puma opts = {}
        opts = opts.dup
        puma_args = opts.delete(:puma_args) || []
        raise("Unrecognized options #{opts.inspect}") if opts.keys.any?

        desc 'start', 'Starts the Puma and any other required thread'
        define_method :start do
          require 'puma/cli'
          Puma::CLI.new(puma_args).run
        end
      end

      def add_startup_benchmark
        # Shows execution time to the end of the run
        def self.start(given_args = ARGV, config = {})
          config[:shell] ||= Thor::Base.shell.new
          require 'benchmark'
          bm = Benchmark.measure { |x| super given_args, config }
          config[:shell].say "\n#{bm.total.round(3)}s task run time"
        end
      end
    end

    def self.included klass
      klass.extend ClassMethods
    end
  end
end

