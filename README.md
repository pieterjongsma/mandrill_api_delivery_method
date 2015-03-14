Send mails through Mandrill API with the standard Mail library. This plugin provides a delivery method for Mail that requires no configuration, except for an API key.

Using Mandrill API instead of an SMTP server enables you to configure many more options, such as specifying a delivery time other than now. For more information on all allowed options, please consult the Mandrill gem documentation at https://mandrillapp.com/api/docs/messages.html#method=send.

# Setup

If you're using Rails, the plugin will automatically register as a delivery method under `:mandrill_api`. You just need to specify you want to use it as the default delivery method for action mailer in `config/environments/production.rb`

    config.action_mail.delivery_method = :mandrill_api

By default, the Mandrill API key is loaded from the environment as `MANDRILL_API_KEY`. If you're using a different mechanism for loading keys, you can simply overwrite the delivery method specification. For instance in `config/initializers/setup_mail.rb`

    ActionMailer::Base.add_delivery_method :mandrill_api, MandrillDeliveryMethod::DeliveryMethod, api_key: "foo123"
