require "spec_helper"

describe "Refresh interval fieldset", :type => :controller do
  render_views
  fixtures :users, :email_addresses, :user_preferences

  before do
    @request.session[:user_id] = 1 # admin
  end

  describe UsersController do
    it "adds the refresh interval in its own fieldset on the user form" do
      get :edit, :params => { :id => 2 }

      expect(response).to have_http_status(:success)
      # Its own fieldset, which does not swallow the fields added after it
      assert_select 'fieldset:has(input#refresh_refresh_interval) p', 1
    end
  end

  describe MyController do
    it "adds the refresh interval in its own fieldset on the account page" do
      get :account

      expect(response).to have_http_status(:success)
      # Its own fieldset, which does not swallow the fields added after it
      assert_select 'fieldset:has(input#refresh_refresh_interval) p', 1
    end
  end
end
