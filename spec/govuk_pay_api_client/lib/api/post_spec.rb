require 'rails_helper'
require 'support/shared_examples_for_api_calls'

RSpec.describe GovukPayApiClient::Api, '#post' do
  include_examples 'anonymous object'

  it 'exposes an excon client' do
    Excon.stub(
      {
        method: :post,
        body: { parameter: 'parameter' }.to_json,
        headers: {
          "Authorization" => "Bearer deadbeef",
          "Content-Type" => "application/json",
          "Accept" => "application/json"
        },
        path: '/endpoint',
        persistent: true
      },
      status: 200, body: { response: 'response' }.to_json
    )
    object.tap do |o|
      expect { o.post }.not_to raise_error
      expect(o.response_body).to eq({ response: 'response' })
    end
  end

  context 'common errors' do
    it 'raises an exception on 404' do
      Excon.stub(
        {
          method: :post,
          path: '/endpoint',
        },
        status: 404
      )
      expect { object.post }.to raise_error(GovukPayApiClient::Unavailable, '404')
    end

    it 'raises an exception on 500' do
      Excon.stub(
        {
          method: :post,
          path: '/endpoint',
        },
        status: 500
      )
      expect { object.post }.to raise_error(GovukPayApiClient::Unavailable, '500')
    end
  end

  context 'the client dies without returning' do
    let(:excon) {
      class_double(Excon)
    }

    before do
      expect(excon).to receive(:post).and_raise(Excon::Error, 'it died')
      expect(object).to receive(:client).and_return(excon)
    end

    it 'raises an exception if the client dies' do
      expect { object.post }.to raise_error(GovukPayApiClient::Unavailable, 'it died')
    end
  end
end
