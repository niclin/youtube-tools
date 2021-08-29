class FetchDonateService

  API_ENDPOINT = "https://youtube.googleapis.com/youtube/v3/superChatEvents".freeze

  def initialize(user)
    @user = user
  end

  def perform
    identity = @user.identities.find_by(provider: "google_oauth2")

    return if identity.blank?

    refresh_token!(identity) if Time.zone.at(identity.expires_at_unix) <= Time.zone.now

    access_token = identity.reload.token

    data = fetch_super_chat_list(access_token)

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
        kind: item["kind"],
        donate_at: item["snippet"]["createdAt"]
      )
    end

    # 超怪， Youtube 給了 nextPageToken 之後，無論在官方的 API 測試，或是直接打，都到不了下一頁
    # 看了一些資訊，似乎沒辦法爬完所有紀錄？
    # ref: https://stackoverflow.com/questions/25918405/youtube-api-v3-page-tokens
    #
    # total_results = data["pageInfo"]["totalResults"]
    # current_page_results = data["pageInfo"]["resultsPerPage"]


    # if total_results != @user.donate_histories.size

    #   data = fetch_super_chat_list(access_token, data["nextPageToken"])

    #   # binding.pry
    # end
  end

  private

  def fetch_super_chat_list(access_token, page_token = nil)

    params = { key: Rails.application.credentials.google_auth[:api_key], :maxResults => 50 }

    if page_token.present?
      params = params.merge({ :pageToken => page_token })
    end

    response = RestClient.get(API_ENDPOINT, { params: params, :Authorization => "Bearer #{access_token}" })

    JSON.parse(response.body)
  end

  def refresh_token!(identity)
    response = RestClient.post("https://oauth2.googleapis.com/token", {
      client_id: Rails.application.credentials.google_auth[:client_id],
      client_secret: Rails.application.credentials.google_auth[:secret],
      refresh_token: identity.refresh_token,
      grant_type: "refresh_token"})

    data = JSON.parse(response.body)

    identity.update!(
      token: data["access_token"],
      expires_at_unix: Time.zone.now + data["expires_in"].to_i.seconds
    )
  end
end
