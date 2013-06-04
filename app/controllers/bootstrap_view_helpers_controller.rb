# This controller displays working examples of the helpers.
#
# After installation, restart your rails server and point your browser to:
#
#   http://<app_name>/bootstrap_view_helpers
#
class BootstrapViewHelpersController < ApplicationController
  layout 'bootstrap_view_helpers'
  
  def index
  end
  
  def flash_helper
    flash.now[:notice] = ":notice is mapped to :info"
    flash.now[:alert] = ":alert is mapped to :error"
    flash.now[:warning] = 'Unrecognized types use Bootstrap default'
    flash.now[:success] = "The operation was a success"
    flash.now[:error] = "There was an error"
    flash.now[:info] = "Here is some info"
  end
end