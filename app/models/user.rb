class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :omniauthable, :omniauth_providers => [:google_oauth2]

  has_many :donate_events
  has_many :donate_histories
  has_many :identities

  def self.from_omniauth(auth, signed_in_resource = nil)
    identity = Identity.find_for_oauth(auth)

    user = signed_in_resource ? signed_in_resource : identity.user

    if user.nil?
      email = auth.info.email

      user = User.where(email: email).first if email

      if user.nil?
        user = User.new(name: auth.info.name.gsub(/\s+/, '_'),
                        email: auth.info.email,
                        # avatar: auth.info.image,
                        password: Devise.friendly_token[0,20])
        user.save!
      end
    end

    if identity.user != user
      identity.user = user
      identity.token = auth.credentials.token
      identity.refresh_token = auth.credentials.refresh_token
      identity.expires_at_unix = auth.credentials.expires_at
      identity.save!
    end

    user
  end
end
