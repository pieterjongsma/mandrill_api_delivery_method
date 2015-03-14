require "spec_helper"

describe MandrillDeliveryMethod::DeliveryMethod do
  before do
    Mail.defaults do
      delivery_method MandrillDeliveryMethod::DeliveryMethod, api_key: ENV["MANDRILL_API_KEY"]
    end
  end
  
  it 'raises an exception if no api key specified' do
    expect { MandrillDeliveryMethod::DeliveryMethod.new }.to raise_exception(MandrillDeliveryMethod::DeliveryMethod::InvalidOption)
    expect { MandrillDeliveryMethod::DeliveryMethod.new(api_key: "123") }.to_not raise_exception
  end
  
  context 'mail message extension' do
    it 'has deliver_at' do
      m = Mail::Message.new
      date = Time.now
      m.deliver_at = date
      expect(m.deliver_at).to eq(date)
    end
    
    it 'has mandrill_options' do
      m = Mail::Message.new
      options = {a: 'foo', b: 'bar'}
      m.mandrill_options = options
      expect(m.mandrill_options).to eq(options)
    end
  end
  
  
end