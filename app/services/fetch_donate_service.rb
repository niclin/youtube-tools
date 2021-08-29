class FetchDonateService

  API_ENDPOINT = "https://youtube.googleapis.com/youtube/v3/superChatEvents".freeze

  def initialize(user)
    @user = user
  end

  def perform
    access_token = @user.identities.find_by(provider: "google_oauth2").token

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
      binding.pry
    end

    response = RestClient.get(API_ENDPOINT, { params: params, :Authorization => "Bearer #{access_token}" })

    JSON.parse(response.body)
  end
end
