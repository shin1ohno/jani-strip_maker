$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rspec/collection_matchers'
require 'jani/strip_maker'
require "codeclimate-test-reporter"

if ENV["CI"]
  CodeClimate::TestReporter.start
end
