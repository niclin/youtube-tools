Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, Rails.application.credentials.google_auth[:client_id], Rails.application.credentials.google_auth[:secret],
  {
    scope: "userinfo.email, userinfo.profile, https://www.googleapis.com/auth/youtube.readonly"
  }
end

OmniAuth.config.allowed_request_methods = %i[get]
OmniAuth.config.silence_get_warning = true