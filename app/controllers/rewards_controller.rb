class RewardsController < ApplicationController
    def index

    end

    def show
        @reward = Reward.find(params[:id])

        render :partial => "reward", :object => @reward
    end
end
