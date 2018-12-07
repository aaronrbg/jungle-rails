class Admin::DashboardController < ApplicationController

  http_basic_authenticate_with name: ENV["HTTPAUTH"], password: ENV["HTTPAUTHPASSWORD"]
  
  def show
  end
end
