class UsersController < ApplicationController
  before_action :validate_url_hack

  def validate_url_hack
    # Check the params hash to see if the passed :id matches the current user's id
    # (note the .to_i on params[:id], as you are comparing against a Fixnum)
    unless params[:id].to_i == current_user.id
      # This line redirects the user to the previous action
      redirect_to root_path
    end
  end


  # GET summary
  def summary
    @user = current_user
  end
end
