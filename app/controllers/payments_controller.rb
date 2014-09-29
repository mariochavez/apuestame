require 'paypal-sdk-rest'

class PaymentsController < ApplicationController
include PayPal::SDK::REST

  def index
  end

  def show
      reward = Reward.find(params[:id])

      @api = PayPal::SDK::REST.set_config(
        :mode => :sandbox,  # Set :sandbox or :live
        :client_id     => APP_CONFIG['paypal_client_id'],
        :client_secret => APP_CONFIG['paypal_secret']
      )
      @api.token

      amount = reward.amount.to_i.to_s

      @payment = PayPal::SDK::REST::Payment.new({
        :intent => "sale",
        :payer => {
            :payment_method => "paypal" },
            :redirect_urls => {
                :return_url => url_for(:controller => 'payments', :action => 'success', :success => true, :reward => reward.id),
                :cancel_url => url_for(:controller => 'payments', :action => 'success', :success => false, :reward => reward.id),
            },
            :transactions => [ {
                :amount => {
                    :total => amount,
                    :currency => "MXN" },
                    :description => "Bidding for Reward: #{reward.description}" }
            ]
        })


        res = @payment.create

        if res
            payment_id = @payment.id

            Donation.create!(reward: reward, identity: current_identity, paypal_payment: payment_id, amount: reward.amount.to_f)
            render :json => {:payment_id => payment_id, :links => @payment.links }
        else
            render :json => false
        end
  end

  def success
      paypal_response = params[:success] == "true"
      reward = Reward.find(params[:reward])

      if paypal_response
          @message = "Thanks for bidding for the Reward #{reward.description}, soon you will recieve a email if you win the Auction."
          #render :html => 'Pago Valido'
      else
          @message = "You cancel your biding, it's ok, perhaps you click by mistake."
      end
  end

end
