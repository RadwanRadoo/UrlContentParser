require 'rails_helper'

RSpec.describe Api::UrlsController, type: :controller do
  include_context 'API Context'

  describe 'GET /index succeeded' do
    before do
      get :index
    end

    it { expect(response.code).to eq '200' }
    it_behaves_like 'JSON APIs when request succeeds'
    it { expect(payload).to be_kind_of Object }
    it { expect(payload).to include('urls') unless payload.kind_of?(Array) }
  end


  describe 'POST /create succeeded' do

    before do
      post :create, url: { link: 'http://www.nokogiri.org/' }
    end

    it { expect(response.code).to eq '201' }
    it_behaves_like 'JSON APIs when request succeeds'
    it { expect(payload).to be_kind_of Object }
    it { expect(payload).to be_kind_of(Hash) }
    it { expect(payload.keys).to include('message') }
    it { expect(payload['message']).to eql('page content saved successfully') }
  end


  describe 'POST /create Failed' do
    before do
      post :create, url: { link: 'http://fdsdsfdsfdsfdsf.com' }
    end

    it_behaves_like 'JSON APIs when request fails'
  end

end