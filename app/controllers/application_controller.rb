class ApplicationController < ActionController::Base
  private
    def is_authen?
      return session[:authen] 
    end

    def is_admin?
      # TODO: check is admin
      return User.find(session[:userid].to_i).user_type == 0
    end

    def is_seller?
      # TODO: check is admin
      return User.find(session[:userid].to_i).user_type == 1
    end

    def is_buyer?
      # TODO: check is admin
      return User.find(session[:userid].to_i).user_type == 2
    end

end
