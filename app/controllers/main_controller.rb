class MainController < ApplicationController

    def getGeolocatedCampaigns
        odt = params[:odt]

        @nearest = Campaign.near([odt[:lat], odt[:lng]], 50)

        render :json => @nearest
        #render :partial => 'nearest', :collection => @nearest
    end
end
