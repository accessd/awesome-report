# frozen_string_literal: true

require 'minitest/autorun'
require 'rubygems'
require 'bundler/setup'
Bundler.require(:default, :test)
Dir["#{__dir__}/../lib/*.rb"].sort.each { |f| require f }
require_relative '../report'
