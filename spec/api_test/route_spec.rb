require 'rails_helper'

RSpec.describe Api::UrlsController, type: :controller do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/urls').to route_to('api/urls#index', format: :json)
    end

    it 'routes to #create' do
      expect(post: '/api/urls').to route_to('api/urls#create', format: :json)
    end
  end
end
