class ApplicationController < ActionController::Base
     skip_before_action :verify_authenticity_token
     before_action :set_active_storage_host

     def set_active_storage_host
          ActiveStorage::Current.host = ENV['active_storage_host']
     end
end
