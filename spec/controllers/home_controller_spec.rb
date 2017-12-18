require 'spec_helper'
describe HomeController do
  describe 'Get#top' do
    before do
      get :top
    end
    it 'リクエストは200 OKとなること' do
      expect(response.status).to eq 200
    end
    it 'topテンプレートを表示すること' do
      expect(response).to render_template :top
    end
  end
  describe 'Post#top' do
    describe '正常系' do
      before do
        @card = "H2 H3 H4 H5 H6"
        @result = {"result"=>[{"card"=>"H2 H3 H4 H5 H6", "hand"=>"ストレートフラッシュ", "best"=>true}]}
        post :top, card: @card
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
      it '@resultに正しくデータが入っているか' do
        expect(assigns(:result)).to eq @result
      end
      it 'topテンプレートを表示すること' do
        expect(response).to render_template :top
      end
    end
    describe 'エラー' do
      before do
        @card = "H2 H3 H4 H5 V6"
        @result = {"error"=>[{"card"=>"H2 H3 H4 H5 V6", "msg"=>"5番目のカード指定文字が不正です。(V6)"}]}
        post :top, card: @card
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
      it '@resultに正しくデータが入っているか' do
        expect(assigns(:result)).to eq @result
      end
      it 'topテンプレートを表示すること' do
        expect(response).to render_template :top
      end
    end
    describe 'エラー2' do
      before do
        @card = ""
        @result = {"error"=>[{"msg"=>"5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）"}]}
        post :top, card: @card
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
      it '@resultに正しくデータが入っているか' do
        expect(assigns(:result)).to eq @result
      end
      it 'topテンプレートを表示すること' do
        expect(response).to render_template :top
      end
    end
  end
end
