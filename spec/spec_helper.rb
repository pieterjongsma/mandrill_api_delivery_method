require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require "mandrill_api_delivery_method"

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
end
