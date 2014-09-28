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

  def new
    return root_path if !current_identity.eligible?

    new!
  end

  def create
    @campaign = Campaign.new secure_params
    @campaign.identity =  current_identity
    @campaign.save

    create!
  end

  def edit
    @campaign = Campaign.where(id: params[:id]).where(identity: current_identity).first

    return redirect_to campaigns_path, notice: "Campaign doesn't exists" if @campaign.nil?

    #@campaign.update_attributes secure_params
    edit!
  end

  def update
    @campaign = Campaign.where(id: params[:id]).where(identity: current_identity).first

    return redirect_to campaigns_path, notice: "Campaign doesn't exists" if @campaign.nil?

    @campaign.update_attributes secure_params
    update!
  end

  def secure_params
    params.require(:campaign).permit :name, :amount, :end_date, :description, :tags, :address, rewards_attributes: [:amount, :description, :id, :_destroy]
  end
end
