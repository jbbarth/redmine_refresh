require "spec_helper"

describe RedmineRefresh do
  fixtures :users, :user_preferences

  before do
    @user = User.find(1) #permissions don't matter
  end

  context "#refresh_interval_for" do
    it "should return 120 by default " do
      expect(RedmineRefresh.refresh_interval_for(@user)).to eq 120
    end

    it "should return second params if >= 10" do
      expect(RedmineRefresh.refresh_interval_for(@user, "10")).to eq 10
      expect(RedmineRefresh.refresh_interval_for(@user, 12)).to eq 12
    end

    it "should not return second param if not >= 10" do
      expect(RedmineRefresh.refresh_interval_for(@user, 9)).to eq 120
      expect(RedmineRefresh.refresh_interval_for(@user, "abcd")).to eq 120
      expect(RedmineRefresh.refresh_interval_for(@user, -20)).to eq 120
    end

    it "should save parameter in user preferences if modified and valid" do
      expect(@user.reload.pref[:refresh_interval]).to eq nil
      expect(RedmineRefresh.refresh_interval_for(@user, "10"))
      expect(@user.reload.pref[:refresh_interval]).to eq 10
      expect(RedmineRefresh.refresh_interval_for(@user, "30"))
      expect(@user.reload.pref[:refresh_interval]).to eq 30
      expect(RedmineRefresh.refresh_interval_for(@user, "abc"))
      expect(@user.reload.pref[:refresh_interval]).to eq 30
    end

    it "should not save user preferences if parameter is untouched" do
      RedmineRefresh.refresh_interval_for(@user, "10")
      expect(@user.reload.pref[:refresh_interval]).to eq 10
      allow(@user.pref).to receive(:save) { raise(Exception, "This shouldn't be called !") }
      expect{ RedmineRefresh.refresh_interval_for(@user, "10") }.to_not raise_error
    end

    it "should get the user preference if no valid parameter provided" do
      @user.pref[:refresh_interval] = 30
      @user.pref.save
      expect(RedmineRefresh.refresh_interval_for(@user)).to eq 30
    end

    it "should not get the user preference if a valid parameter is provided" do
      @user.pref[:refresh_interval] = 30
      @user.pref.save
      expect(@user.reload.pref[:refresh_interval]).to eq 30
      expect(RedmineRefresh.refresh_interval_for(@user, "50")).to eq 50
    end
  end

  context "#refresh_status_for_controller" do
    it "should return false if no controller provided" do
      assert !RedmineRefresh.refresh_status_for_controller(@user)
    end

    it "should return false by default" do
      assert !RedmineRefresh.refresh_status_for_controller(@user, "my")
    end

    it "should proxy to user preferences for refresh_status" do
      @user.pref[:refresh_status] = {"my" => true}
      @user.pref.save
      @user.reload
      assert RedmineRefresh.refresh_status_for_controller(@user, "my")
      assert !RedmineRefresh.refresh_status_for_controller(@user, "other")
    end

    it "should be falsy for not-logged user" do
      @user = User.anonymous
      @user.pref[:refresh_status] = {"my" => true}
      assert !RedmineRefresh.refresh_status_for_controller(@user, "my")
    end
  end

  context "#save_refresh_status_for_controller" do
    before do
      @user.pref[:refresh_status] = {"my" => true}
      @user.pref.save
      @user.reload
    end

    it "should save refresh_status for this controller if needed" do
      RedmineRefresh.save_refresh_status_for_controller(@user, "my", false)
      @user.reload
      assert !RedmineRefresh.refresh_status_for_controller(@user, "my")
    end

    it "should not save refresh_status for this controller if not changed" do
      allow(@user.pref).to receive(:save) { raise(Exception, "This shouldn't be called !") }
      expect{ RedmineRefresh.save_refresh_status_for_controller(@user, "my", true) }.to_not raise_error
    end
  end
end
