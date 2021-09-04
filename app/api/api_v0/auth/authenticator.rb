module ApiV0
  module Auth
    class Authenticator
      def initialize(request)
        @request = request
      end

      def authenticate!
        check_token!
        token
      end

      def token
        @token = ApiAccessToken.joins(:user).where(key: request_token).first
      end

      def check_token!
        return request_token unless token
      end

      def request_token
        @request.headers["X-Donate-Tool"]
      end
    end
  end
end
