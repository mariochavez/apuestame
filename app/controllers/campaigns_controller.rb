class CampaignsController < ApplicationController
  include Restful::Base
  respond_to :html

  before_action :authenticate!

  restful model: :campaign

  def create
    @campaign = Campaign.new secure_params
    @campaign.organization =  current_organization
    @campaign.save

    create!
  end

  def secure_params
    params.require(:campaign).permit :name, :amount, :end_date, :description, :tags
  end
end
