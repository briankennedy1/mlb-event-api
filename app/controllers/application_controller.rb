class ApplicationController < ActionController::API
  include ActionController::Caching::Pages
  self.page_cache_directory = "#{Rails.root.to_s}/public/page_cache"
end
