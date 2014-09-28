class IdentitiesController < ApplicationController
  include Restful::Base

  restful model: :identity

  def show
    @identity = current_identity
  end

  def new
    @identity = Identity.new
  end

  def create
    @identity = Identity.new identity_params

    if @identity.save
      warden.set_user(@identity, scope: :identity)
      redirect_to root_url, notice: t('.sign_up')
    else
      render :new
    end
  end

  def update
    @identity = Identity.where(id: current_identity.id).first

    return redirect_to identity_path, notice: "User Profile doesn't exists" if @identity.nil?

    @identity.update_attributes identity_params
    redirect_to identity_path, notice: "User profile has been updated"
  end

private
  def identity_params
    params.require(:identity).permit :email, :password, :password_confirmation, :name, :address, :description, :rfc, :paypal
  end

end
