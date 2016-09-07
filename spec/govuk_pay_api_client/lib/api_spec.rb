require 'rails_helper'
require 'support/shared_examples_for_api_calls'

RSpec.describe GovukPayApiClient::Api, '.call' do
  include_examples 'anonymous object'

  it 'gets added to the encapsulating class' do
    expect(object.class.call).to eq('called')
  end

  it 'gets passes arguments' do
    expect(object.class.call(' bob')).to eq('called bob')
  end
end
