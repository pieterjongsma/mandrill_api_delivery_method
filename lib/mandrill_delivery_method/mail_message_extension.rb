require 'mail'

Mail::Message.class_eval do
  attr_accessor :deliver_at
  attr_accessor :mandrill_options
end