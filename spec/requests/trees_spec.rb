require 'rails_helper'

RSpec.describe "Trees", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/trees/index"
      expect(response).to have_http_status(:success)
    end
  end

end
