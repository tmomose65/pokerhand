require 'spec_helper'

describe 'EvalHand' do
  describe 'EvalHand.eval_hand()が正常に動作すること' do
    before do
      @card = []
    end
    it 'ハイカード' do
      @card.push "H1 H2 H3 H4 S6"
      @result = EvalHand.eval_hand(@card)
      @ex_result = "ハイカード"
      expect(@result["result"][0]["hand"]).to eq @ex_result
    end
    it 'ワンペア' do
      @card.push "H1 H2 H3 H4 S4"
      @result = EvalHand.eval_hand(@card)
      @ex_result = "ワンペア"
      expect(@result["result"][0]["hand"]).to eq @ex_result
    end
    it 'ツーペア' do
      @card.push "H1 H2 H3 S2 S3"
      @result = EvalHand.eval_hand(@card)
      @ex_result = "ツーペア"
      expect(@result["result"][0]["hand"]).to eq @ex_result
    end
    it 'スリー・オブ・ア・カインド' do
      @card.push "H1 H2 S2 D2 S6"
      @result = EvalHand.eval_hand(@card)
      @ex_result = "スリー・オブ・ア・カインド"
      expect(@result["result"][0]["hand"]).to eq @ex_result
    end
    it 'ストレート' do
      @card.push "H1 H2 H3 H4 S5"
      @result = EvalHand.eval_hand(@card)
      @ex_result = "ストレート"
      expect(@result["result"][0]["hand"]).to eq @ex_result
    end
    it 'フラッシュ' do
      @card.push "H1 H2 H3 H4 H6"
      @result = EvalHand.eval_hand(@card)
      @ex_result = "フラッシュ"
      expect(@result["result"][0]["hand"]).to eq @ex_result
    end
    it 'フルハウス' do
      @card.push "H1 S1 H3 S3 D3"
      @result = EvalHand.eval_hand(@card)
      @ex_result = "フルハウス"
      expect(@result["result"][0]["hand"]).to eq @ex_result
    end

    it 'フォー・オブ・ア・カインド' do
      @card.push "H1 S1 D1 C1 S6"
      @result = EvalHand.eval_hand(@card)
      @ex_result = "フォー・オブ・ア・カインド"
      expect(@result["result"][0]["hand"]).to eq @ex_result
    end
    it 'ストレートフラッシュ' do
      @card.push "H1 H2 H3 H4 H5"
      @result = EvalHand.eval_hand(@card)
      @ex_result = "ストレートフラッシュ"
      expect(@result["result"][0]["hand"]).to eq @ex_result
    end
    it '5枚のカードの指定がない時' do
      @card.push "H1 H2 H3 H4"
      @result = EvalHand.eval_hand(@card)
      @ex_result = "5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）"
      expect(@result["error"][0]["msg"]).to eq @ex_result
    end
    it '指定外の文字を利用している時' do
      @card.push "H1 H2 H3 H4 J6"
      @result = EvalHand.eval_hand(@card)
      @ex_result = "5番目のカード指定文字が不正です。(J6)"
      expect(@result["error"][0]["msg"]).to eq @ex_result
    end
    it 'カードに重複がある時' do
      @card.push "H1 H2 H3 H4 H4"
      @result = EvalHand.eval_hand(@card)
      @ex_result = "カードが重複しています。"
      expect(@result["error"][0]["msg"]).to eq @ex_result
    end
  end
end
