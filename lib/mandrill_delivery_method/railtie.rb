module MandrillDeliveryMethod
  class Railtie < Rails::Railtie
    initializer "mandrill_delivery_method.add_delivery_method" do
      ActiveSupport.on_load :action_mailer do
        ActionMailer::Base.add_delivery_method :mandrill_api, MandrillDeliveryMethod::DeliveryMethod
      end
    end
  end
end
