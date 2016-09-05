require 'rails_helper'
require 'support/shared_examples_for_govpay'

def fee
  Fee.create
end

RSpec.feature 'process payment' do
  include_examples 'govpay payment response', fee

  describe '#pay' do
    it '"redirects" to govpay payment URL' do
      visit "/fees/#{fee.id}/pay"
    end
  end
end
