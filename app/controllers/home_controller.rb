require 'eval_hand.rb'
class HomeController < ApplicationController
  def top
    @card = []
    @card.push params[:card]
    if params[:card].present?
      @result = EvalHand.eval_hand(@card)
      puts @card
      puts @result
      if @result["result"].present?
        puts @result["result"]
        puts @result["result"][0]["hand"]
      end
      if @result["error"].present?
        puts @result["error"][0]["msg"]
      end
    else
      @result = {}
      @error = []
      @re = {}
      @re["msg"] = "5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）"
      @error.push @re
      @result["error"] = @error
    end
    render
  end
end
