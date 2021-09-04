module ApiV0
  class LotteryResults < Grape::API
    before { authenticate! }

    desc "取得 donate 目前中獎記錄"
    params do
      requires :token, type: String, desc: "DonateEvent token"
    end
    get "/lottery_results" do
      donate_event = current_user.donate_events.find_by_token(params[:token])

      present donate_event.lottery_results, with: ApiV0::Entities::LotteryResult
    end
  end
end