class ApiAccessToken < ApplicationRecord
  belongs_to :user

  def regenerate_keys!
    return if enabled?
    begin
      self.key = SecureRandom.urlsafe_base64(30).tr('_-', 'xx')
      self.enable = true
    end while ApiAccessToken.where(key: key).any?
  end

  def enabled?
    enable
  end

  def revoke!
    return if !enabled?
    self.update_attribute(:enable, false)
  end
end
