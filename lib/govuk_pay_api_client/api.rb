module GovukPayApiClient
  module Api
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def call(*args)
        new(*args).call
      end
    end

    def post
      @post ||=
        client.post(path: endpoint, body: request_body.to_json).tap { |resp|
          # Only timeouts and network issues raise errors.
          handle_response_errors(resp)
          @body = resp.body
        }
    rescue Excon::Error => e
      raise Unavailable, e
    end

    def get
      @get ||=
        client.get(path: endpoint).tap { |resp|
          # Only timeouts and network issues raise errors.
          handle_response_errors(resp)
          @body = resp.body
        }
    rescue Excon::Error => e
      raise Unavailable, e
    end

    def response_body
      @response_body ||= JSON.parse(@body, symbolize_names: true)
    rescue JSON::ParserError
      ''
    end

    private

    def handle_response_errors(resp)
      if (400..599).cover?(resp.status)
        raise Unavailable, resp.status
      end
    end

    def client
      @client ||= Excon.new(
        ENV.fetch('GOVUK_PAY_API_URL'),
        headers: {
          'Authorization' => "Bearer #{ENV.fetch('GOVUK_PAY_API_KEY')}",
          'Content-Type' => 'application/json',
          'Accept' => 'application/json'
        },
        persistent: true
      )
    end
  end
end
