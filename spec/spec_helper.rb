require 'rubygems'
require 'rspec'
require 'pry'

RSpec.configure do |config|
   config.color = true
   config.tty = true
   # config.formatter = :documentation # :documentation, :progress, :html, :textmate
end

$LOAD_PATH.unshift File.expand_path('lib')
require 'mini_cli'

$LOAD_PATH.unshift File.expand_path('spec/support')

