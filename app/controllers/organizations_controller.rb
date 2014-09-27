class OrganizationsController < ApplicationController

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new organization_params

    if @organization.save
      warden.set_user(@organization, scope: :organization)
      redirect_to root_url, notice: t('.sign_up')
    else
      render :new
    end
  end

private
  def organization_params
    params.require(:organization).permit :email, :password, :password_confirmation, :Name, :Address, :Description, :RFC, :Paypal
  end

end
