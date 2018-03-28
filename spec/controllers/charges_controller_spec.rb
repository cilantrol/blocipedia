require 'rails_helper'

RSpec.describe ChargesController, type: :controller do

  let(:my_user) { create(:user)}
  let(:my_wiki) { create(:wiki , user: my_user) }


  before(:each) do
    my_user.confirm
    sign_in my_user
  end

  context "standard member"

    describe "GET #create" do
      it "returns http success" do
        get :create
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end
    end
  end
end
