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
  
  context 'delivery' do
    it 'should succeed' do
      Mail.deliver do
        from     'Foo <foo@example.com>'
        sender   'Baz <baz@example.com>'
        reply_to 'No Reply <no-reply@example.com>'
        to       'Bar <bar@example.com>'
        cc       'Qux <qux@example.com>'
        bcc      'Qux <qux@example.com>'
        subject  'Hello'
        body     'World! http://example.com'
      end
    end
  end
end