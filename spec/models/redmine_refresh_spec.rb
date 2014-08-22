require "spec_helper"

describe RedmineRefresh do
  fixtures :users, :user_preferences

  before do
    @user = User.find(1) #permissions don't matter
  end

  context "#refresh_interval_for" do
    it "should return 120 by default " do
      RedmineRefresh.refresh_interval_for(@user).should == 120
    end

    it "should return second params if >= 10" do
      RedmineRefresh.refresh_interval_for(@user, "10").should == 10
      RedmineRefresh.refresh_interval_for(@user, 12).should == 12
    end

    it "should not return second param if not >= 10" do
      RedmineRefresh.refresh_interval_for(@user, 9).should == 120
      RedmineRefresh.refresh_interval_for(@user, "abcd").should == 120
      RedmineRefresh.refresh_interval_for(@user, -20).should == 120
    end

    it "should save parameter in user preferences if modified and valid" do
      @user.reload.pref[:refresh_interval].should == nil
      RedmineRefresh.refresh_interval_for(@user, "10")
      @user.reload.pref[:refresh_interval].should == 10
      RedmineRefresh.refresh_interval_for(@user, "30")
      @user.reload.pref[:refresh_interval].should == 30
      RedmineRefresh.refresh_interval_for(@user, "abc")
      @user.reload.pref[:refresh_interval].should == 30
    end

    it "should not save user preferences if parameter is untouched" do
      RedmineRefresh.refresh_interval_for(@user, "10")
      @user.reload.pref[:refresh_interval].should == 10
      @user.pref.stubs(:save).raises(Exception, "This shouldn't be called !")
      assert_nothing_raised do
        RedmineRefresh.refresh_interval_for(@user, "10")
      end
    end

    it "should get the user preference if no valid parameter provided" do
      @user.pref[:refresh_interval] = 30
      @user.pref.save
      RedmineRefresh.refresh_interval_for(@user).should == 30
    end

    it "should not get the user preference if a valid parameter is provided" do
      @user.pref[:refresh_interval] = 30
      @user.pref.save
      @user.reload.pref[:refresh_interval].should == 30
      RedmineRefresh.refresh_interval_for(@user, "50").should == 50
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
      @user.pref.stubs(:save).raises(Exception, "This shouldn't be called !")
      assert_nothing_raised do
        RedmineRefresh.save_refresh_status_for_controller(@user, "my", true)
      end
    end
  end
end
