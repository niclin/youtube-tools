module ApiV0
  module Auth
    class Middleware < Grape::Middleware::Base
      def before
        if auth_provided?
          @env["api_v0.token"] = Authenticator.new(request).authenticate!
          @env["api_v0.user"] ||= @env["api_v0.token"].try(:user)
        end
      end

      def request
        @request ||= ::Grape::Request.new(env)
      end

      def auth_provided?
        request.headers["X-Donate-Tool"].present?
      end
    end
  end
end
