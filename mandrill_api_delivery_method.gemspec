Gem::Specification.new do |s|
  s.name        = "mandrill-api-delivery-method"
  s.version     = "0.2"
  s.author      = "Pieter Jongsma"
  s.email       = "pieter.jongsma@gmail.com"
  s.homepage    = "http://github.com/pieterjongsma/mandrill_api_delivery_method"
  s.summary     = "An ActionMailer delivery method drop-in for using Mandrill's API."
  s.description = "Sends mail through the Mandrill API, allowing you to specify options not available when using SMTP, like delivery time."

  s.files        = Dir["{lib,spec}/**/*", "[A-Z]*"] - ["Gemfile.lock"]
  s.require_path = "lib"

  s.add_development_dependency 'rspec', '~> 2.0'
  s.add_development_dependency 'mail', '~> 2.5'
  s.add_development_dependency 'mandrill-api', '~> 1.0'

  s.rubyforge_project = s.name
  
  s.license = 'GPL'
end
