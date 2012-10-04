require File.dirname(__FILE__) + '/../test_helper'

class RedmineRefreshTest < ActiveSupport::TestCase
  fixtures :users, :user_preferences

  setup do
    @user = User.find(1) #permissions don't matter
  end

  context "#refresh_interval_for" do
    should "return 120 by default " do
      assert_equal 120, RedmineRefresh.refresh_interval_for(@user)
    end

    should "return second params if >= 10" do
      assert_equal 10, RedmineRefresh.refresh_interval_for(@user, "10")
      assert_equal 12, RedmineRefresh.refresh_interval_for(@user, 12)
    end

    should "not return second param if not >= 10" do
      assert_equal 120, RedmineRefresh.refresh_interval_for(@user, 9)
      assert_equal 120, RedmineRefresh.refresh_interval_for(@user, "abcd")
      assert_equal 120, RedmineRefresh.refresh_interval_for(@user, -20)
    end

    should "save parameter in user preferences if modified and valid" do
      assert_equal nil, @user.reload.pref[:refresh_interval]
      RedmineRefresh.refresh_interval_for(@user, "10")
      assert_equal 10, @user.reload.pref[:refresh_interval]
      RedmineRefresh.refresh_interval_for(@user, "30")
      assert_equal 30, @user.reload.pref[:refresh_interval]
      RedmineRefresh.refresh_interval_for(@user, "abc")
      assert_equal 30, @user.reload.pref[:refresh_interval]
    end

    should "not save user preferences if parameter is untouched" do
      RedmineRefresh.refresh_interval_for(@user, "10")
      assert_equal 10, @user.reload.pref[:refresh_interval]
      @user.pref.stubs(:save).raises(Exception, "This shouldn't be called !")
      assert_nothing_raised do
        RedmineRefresh.refresh_interval_for(@user, "10")
      end
    end

    should "get the user preference if no valid parameter provided" do
      @user.pref[:refresh_interval] = 30
      @user.pref.save
      assert_equal 30, RedmineRefresh.refresh_interval_for(@user)
    end

    should "not get the user preference if a valid parameter is provided" do
      @user.pref[:refresh_interval] = 30
      @user.pref.save
      assert_equal 30, @user.reload.pref[:refresh_interval]
      assert_equal 50, RedmineRefresh.refresh_interval_for(@user, "50")
    end
  end
end
