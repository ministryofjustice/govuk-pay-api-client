RSpec.shared_examples 'anonymous object' do
  # Required for run/build ordering in mutation tests.
  let(:object) do
    Class.new do
      include GovukPayApiClient::Api

      def initialize(call = nil)
        @call = call
      end

      def call
        "called#{@call}"
      end

      def endpoint
        '/endpoint'
      end

      def request_body
        { parameter: 'parameter' }
      end
    end.new
  end
end
