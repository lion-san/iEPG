class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

   # ------ ここから下が追加した設定です　-----------------
  #before_filter :allow_cross_domain_access
  #def allow_cross_domain_access
  #  response.headers["Access-Control-Allow-Origin"] = "*"
  #  response.headers["Access-Control-Allow-Headers"] = "Content-Type"
  #  response.headers["Access-Control-Allow-Methods"] = "PUT,DELETE,POST,GET,OPTIONS"
  #end

  after_filter :set_access_control_headers
 
def set_access_control_headers 
headers['Access-Control-Allow-Origin'] = '*' 
headers['Access-Control-Request-Method'] = '*' 
  end
end
