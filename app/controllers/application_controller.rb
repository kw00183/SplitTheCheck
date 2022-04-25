class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :only => [:new, :edit, :create, :update, :vote, :comment, :favorite, :summary]
end
