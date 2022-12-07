class ApplicationController < ActionController::Base
  private
    def is_admin?
      # TODO: check is admin
      return true
    end
end
