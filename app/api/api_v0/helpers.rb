module ApiV0
  module Helpers

    def authenticate!
      raise AuthorizationError if current_user.blank?
    end

    def current_user
      @current_user ||= env["api_v0.user"]
    end

    def client_type
      @client_type ||= request.headers["Client"]
    end

    def client_version_tag
      @client_version_tag ||= request.headers["Client-Version-Tag"]
    end

    def bad_request!(attribute)
      message = ["400 (Bad request)"]
      message << "\"" + attribute.to_s + "\" not given" if attribute
      render_api_error!(message.join(' '), 400)
    end

    def render_api_error!(message, status)
      error!({ 'message' => message }, status, header)
    end
  end
end
