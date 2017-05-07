shared_context "API Context" do
  render_views

  let(:payload) { JSON.parse(response.body) }

  before do
    request.headers['HTTP_ACCEPT'] = 'application/json'
  end
end

shared_examples 'JSON APIs' do
  describe 'response' do
    describe 'content type' do
      it { expect(response.header['Content-Type']).to include "application/json" }
    end
  end
end

shared_examples 'JSON APIs when request succeeds' do
  it_behaves_like 'JSON APIs'

  describe 'success flag' do
    it { expect([200, 201, 202]).to include response.code.to_i }
  end
  describe 'json' do
    it { expect { JSON.parse(response.body) }.not_to raise_exception }
    describe 'data attribute' do
      it { expect(payload).to be_kind_of Object }
    end
  end
end

shared_examples 'JSON APIs when request fails' do
  it { expect([200, 201, 202]).not_to include response.code.to_i }
end
