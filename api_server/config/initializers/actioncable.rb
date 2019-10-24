if Rails.env.development?
  ActionCable.server.config.disable_request_forgery_protection = true
end
