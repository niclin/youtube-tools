class ApiRoot < Grape::API
  PREFIX = '/api'.freeze

  use GrapeLogging::Middleware::RequestLogger,
      logger: Logger.new(Rails.root.join('log', 'api.log')),
      include: [
        GrapeLogging::Loggers::Response.new,
        GrapeLogging::Loggers::FilterParameters.new,
        GrapeLogging::Loggers::ClientEnv.new,
        GrapeLogging::Loggers::RequestHeaders.new
      ]

  format :json

  mount ApiV0::Base
end
