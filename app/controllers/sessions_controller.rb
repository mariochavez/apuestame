class SessionsController < ApplicationController
  def new
    @organization = Organization.new
  end

  def create
    warden.authenticate!(scope: :organization)
    redirect_to root_url, notice: t('.logged_in')
  end

  def destroy
    warden.logout(:organization)
    redirect_to root_url, notice: t('.logged_out')
  end
end

