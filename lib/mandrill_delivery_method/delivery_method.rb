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
          html: mail.html_part.body.to_s,
          text: mail.text_part.body.to_s,
          subject: mail.subject,
          from_email: mail.from.first,
          to: [{
            email: mail.to.first
          }]
        }
      
        async = false
        ip_pool = "Main Pool"
        send_at = mail.deliver_at.present? ? mail.deliver_at.uts.to_s : Time.now.utc.to_s
      
        result = mandrill.messages.send message, async, ip_pool, send_at
      rescue Mandrill::Error => e
        puts "Error delivering mail to Mandrill API: #{e.class} - #{e.message}"
        raise
      end
    end
  end
end
