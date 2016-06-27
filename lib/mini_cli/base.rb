require 'thor'

module MiniCli
  # The base class to inherit from to provide the basic commands of a microservice
  class Base < Thor
    include BaseModule
    add_startup_benchmark
    add_start_puma puma_args: %w{-p 22000}
    add_console_pry
    add_test_rspec
    add_auto_rerun
    add_rubocop
  end
end

