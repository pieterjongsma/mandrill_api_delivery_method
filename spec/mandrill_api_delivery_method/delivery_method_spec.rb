require "spec_helper"

describe MandrillAPIDeliveryMethod::DeliveryMethod do
  before do
    Mail.defaults do
      delivery_method MandrillAPIDeliveryMethod::DeliveryMethod, api_key: ENV["MANDRILL_API_KEY"], test: true
    end
  end
  
  let(:deliveries) { MandrillAPIDeliveryMethod::DeliveryMethod.deliveries }
  before(:each) do
    # Clear deliveries
    MandrillAPIDeliveryMethod::DeliveryMethod.deliveries = []
  end
  
  it 'raises an exception if no api key specified' do
    expect { MandrillAPIDeliveryMethod::DeliveryMethod.new }.to raise_exception(MandrillAPIDeliveryMethod::DeliveryMethod::InvalidOption)
    expect { MandrillAPIDeliveryMethod::DeliveryMethod.new(api_key: "123") }.to_not raise_exception
  end
  
  describe 'mail message extension' do
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
  
  describe 'delivery' do
    context 'plain' do
      before(:each) do
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
      
      it 'should succeed' do
        expect(deliveries.length).to eq 1
      end
    end
    
    context 'html' do
      before(:each) do
        Mail.deliver do
          from     'Foo <foo@example.com>'
          to       'Bar <bar@example.com>'
          subject  'Hello'
          text_part do
            body 'World! http://example.com'
          end
          html_part do
            content_type 'text/html; charset=UTF-8'
            body '<h1>World! http://example.com</h1>'
          end
        end
      end
      
      it 'should succeed' do
        expect(deliveries.length).to eq 1
      end
    end
    
    context 'attachments' do
      before(:each) do
        Mail.deliver do
          from     'Foo <foo@example.com>'
          to       'Bar <bar@example.com>'
          subject  'Hello'
          text_part do
            body 'World! http://example.com'
          end
          attachments[File.basename(__FILE__)] = File.read(__FILE__)
        end
      end
      
      it 'should succeed' do
        expect(deliveries.length).to eq 1
      end
    end
  end
end
