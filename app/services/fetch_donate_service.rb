class FetchDonateService
  def initialize(user)
    @user = user
  end

  def perform
    token = @user.identities.find_by(provider: "google_oauth2").token

    response = RestClient.get('https://youtube.googleapis.com/youtube/v3/superChatEvents', { params: { key: Rails.application.credentials.google_auth[:api_key] },
      :Authorization => "Bearer #{token}" })

    data = JSON.parse(response.body)

    data["items"].each do |item|
      next if DonateHistory.where(uid: item["id"]).exists?

      @user.donate_histories.create!(
        uid: item["id"],
        currency: item["snippet"]["currency"].upcase,
        amount_micros: item["snippet"]["amountMicros"].to_i,
        display_name: item["snippet"]["supporterDetails"]["displayName"],
        donate_channel_id: item["snippet"]["channelId"],
        self_channel_id: item["snippet"]["supporterDetails"]["channelId"],
        message_type: item["snippet"]["messageType"],
        comment: item["snippet"]["commentText"],
        kind: item["kind"]
      )
    end
  end
end