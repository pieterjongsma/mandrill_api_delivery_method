require 'mandrill'

module MandrillDeliveryMethod
  class DeliveryMethod
    class InvalidOption < StandardError; end
  
    attr_accessor :settings
  
    def initialize(options = {})
      raise InvalidOption, "An API key is required when using the Mandrill API delivery method" if options[:api_key].nil?
      self.settings = options
    end
  
    def deliver!(mail)
      begin
        mandrill = Mandrill::API.new self.settings[:api_key]
        
        message = {
          subject: mail.subject,
          from_email: mail.from.first,
          to: [{
            email: mail.to.first
          }]
        }
        
        if not mail.text_part.nil?
          message[:text] = mail.text_part.body.to_s
        end
        
        if not mail.html_part.nil?
          message[:html] = mail.html_part.body.to_s
        end
      
        async = false
        send_at = mail.deliver_at.nil? ? Time.now.utc.to_s : mail.deliver_at.uts.to_s
      
        result = mandrill.messages.send message, async, nil, send_at
      rescue Mandrill::Error => e
        puts "Error delivering mail to Mandrill API: #{e.class} - #{e.message}"
        raise
      end
    end
  end
end
