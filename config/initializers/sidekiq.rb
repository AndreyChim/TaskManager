require 'sidekiq'
require "sidekiq/rails" if defined?(::Rails::Engine) 
require 'sidekiq/web'

Sidekiq.configure_server do |config|
    config.redis = { url: ENV['REDIS_URL'] }
  end
  
Sidekiq.configure_client do |config|
    config.redis = { url: ENV['REDIS_URL'] }
  end