require 'spec_helper'

describe "Card_API", type: :request do
  describe "POST /api/cards/check" do
    describe "正常系" do
      before do
        @cards = {"cards":["H1 H13 H12 H11 H12","H9 C9 S9 H2 C3","C13 D12 C11 H8 H7"]}
        post "/api/cards/check", @cards
        @json = JSON.parse(response.body)
        @response = {"result"=>[{"card"=>"H9 C9 S9 H2 C3","hand"=>"スリー・オブ・ア・カインド","best"=>true},{"card"=>"C13 D12 C11 H8 H7","hand"=>"ハイカード","best"=>false}],"error"=>[{"card"=>"H1 H13 H12 H11 H12","msg"=>"カードが重複しています。"}]}
      end
      it 'リクエストは201 Createdが返ってくること' do
        expect(response).to be_success
        expect(response.status).to eq 201
      end

      it '返却されたデータが仕様どおりになっていること' do
        expect(@json).to eq @response
      end
    end
    describe "異常系" do
      before do
        @cards = {"card":["H1 H13 H12 H11 H12","H9 C9 S9 H2 C3","C13 D12 C11 H8 H7"]}
        post "/api/cards/check", @cards
        @json = JSON.parse(response.body)
        @response = {"error"=>[{"msg"=>"不正なリクエストです。"}]}
      end

      it 'リクエストは400が返ってくること' do
        expect(response.status).to eq 400
      end

      it '返却されたデータが仕様どおりになっていること' do
        expect(@json).to eq @response
      end
    end
  end
end
