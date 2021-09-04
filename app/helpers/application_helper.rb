module ApplicationHelper
  def default_meta_tags
    {
      site:        "Donate Tool",
      description: "",
      keywords:    "",
      # og: {
      #   image: ActionController::Base.helpers.asset_path('logo.png')
      # },
      # fb: {
      #   app_id: "1304370673045470"
      # },
      reverse: true
    }
  end
end