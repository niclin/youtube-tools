class FetchDonateWorker
  include Sidekiq::Worker

  def perform
    User.find_each do |user|

      service = FetchDonateService.new(user)

      service.perform
    end
  end
end