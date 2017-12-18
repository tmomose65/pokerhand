require 'eval_hand.rb'

class Card_API < Grape::API
  resource "cards" do
    helpers do
      def card_params
        ActionController::Parameters.new(params).permit(:cards)
      end
    end

    rescue_from Grape::Exceptions::Base do |e|
      error!({error: [{msg: '不正なリクエストです。'}]}, 400)
    end

    rescue_from :all do |e|
      error!({error: [{msg: '不正なリクエストです。'}]}, 500)
    end

    desc "return a hand"
    params do
      requires :cards, type: Array
    end
    post :check do
      if params[:cards].present?
        EvalHand.eval_hand(params[:cards])
      else
        error!({error: [{msg: '不正なリクエストです。'}]}, 400)
      end
    end
  end
end
