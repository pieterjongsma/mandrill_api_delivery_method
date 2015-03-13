require "spec_helper"

describe MandrillDeliveryMethod::DeliveryMethod do
  before do
    Mail.defaults do
      delivery_method MandrillDeliveryMethod::DeliveryMethod
    end
  end
end