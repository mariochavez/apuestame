class CampaignsController < ApplicationController
  include Restful::Base
  respond_to :html

  before_action :authenticate!, except: [:index]

  restful model: :campaign

  def index
    all = params[:all] == '1'

    if identity_signed_in? && !all
      @campaigns = Campaign.my_campaigns(current_identity).recent
    else
      @campaigns = Campaign.active.recent
    end

    index!
  end

  def create
    @campaign = Campaign.new secure_params
    @campaign.identity =  current_identity
    @campaign.save

    create!
  end

  def edit
    @campaign = Campaign.where(id: params[:id]).where(identity: current_identity).first

    if @campaign.nil?
        return redirect_to campaigns_path, notice: "Campaign doesn't exists"
    end

    @campaign.update_attributes secure_params

    edit!
  end

  def update
    @campaign = Campaign.where(id: params[:id]).where(identity: current_identity).first

    if @campaign.nil?
        return redirect_to campaigns_path, notice: "Campaign doesn't exists"
    end

    @campaign.update_attributes secure_params

    update!
  end

  def secure_params
    params.require(:campaign).permit :name, :amount, :end_date, :description, :tags
  end
end
