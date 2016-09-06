require 'rails_helper'
require 'support/shared_examples_for_api_calls'

RSpec.describe GovukPayApiClient::Api, '#get' do
  include_examples 'anonymous object'

  it 'exposes an excon client' do
    Excon.stub(
      {
        method: :get,
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
      expect { o.get }.not_to raise_error
      expect(o.response_body).to eq({ response: 'response' })
    end
  end

  context 'common errors' do
    it 'raises an exception on 404' do
      Excon.stub(
        {
          method: :get,
          path: '/endpoint',
        },
        status: 404
      )
      expect { object.get }.to raise_error(GovukPayApiClient::Unavailable, '404')
    end

    it 'raises an exception on 500' do
      Excon.stub(
        {
          method: :get,
          path: '/endpoint',
        },
        status: 500
      )
      expect { object.get }.to raise_error(GovukPayApiClient::Unavailable, '500')
    end
  end

  context 'top and bottom of the error range' do
    it 'raises an exception on 400' do
      Excon.stub(
        {
          method: :get,
          path: '/endpoint',
        },
        status: 400
      )
      expect { object.get }.to raise_error(GovukPayApiClient::Unavailable, '400')
    end

    it 'raises an exception on 599' do
      Excon.stub(
        {
          method: :get,
          path: '/endpoint',
        },
        status: 599
      )
      expect { object.get }.to raise_error(GovukPayApiClient::Unavailable, '599')
    end
  end

  context 'incorrect response codes' do
    it 'eats a 399 (not a real code)' do
      Excon.stub(
        {
          method: :get,
          path: '/endpoint',
        },
        status: 399
      )
      expect { object.get }.not_to raise_error
    end

    it 'eats a 600 (not a real code)' do
      Excon.stub(
        {
          method: :get,
          path: '/endpoint',
        },
        status: 600
      )
      expect { object.get }.not_to raise_error
    end
  end

  context 'the client dies without returning' do
    let(:excon) {
      class_double(Excon)
    }

    before do
      expect(excon).to receive(:get).and_raise(Excon::Error, 'it died')
      expect(object).to receive(:client).and_return(excon)
    end

    it 'raises an exception if the client dies' do
      expect { object.get }.to raise_error(GovukPayApiClient::Unavailable, 'it died')
    end
  end

  it 'does not choke on blank resposnes' do
    Excon.stub(
      {
        method: :get,
        headers: {
          "Authorization" => "Bearer deadbeef",
          "Content-Type" => "application/json",
          "Accept" => "application/json"
        },
        path: '/endpoint',
        persistent: true
      },
      status: 201
    )
    object.tap do |o|
      expect { o.get }.not_to raise_error
      expect(o.response_body).to eq('')
    end
  end
end
