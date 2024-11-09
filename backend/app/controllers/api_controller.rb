class ApiController < ActionController::API
  include ActionController::MimeResponds
  before_action :set_active_storage_host

  def set_active_storage_host
    ActiveStorage::Current.host = ENV['active_storage_host']
  end
end