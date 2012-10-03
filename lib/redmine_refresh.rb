module RedmineRefresh
  extend self #... so we can call RedmineRefresh.<method> directly

  DEFAULT_INTERVAL = 120

  def refresh_interval_for(user, refresh_param = nil)
    interval = DEFAULT_INTERVAL
    user_interval = user.pref[:refresh_interval].to_i
    #if parameter is provided
    if refresh_param.to_i >= 10
      interval = refresh_param.to_i
      #save it if modified
      if interval != user_interval
        user.pref[:refresh_interval] = interval
        user.pref.save
      end
    #if not, get the user's
    elsif user_interval >= 10
      interval = user_interval
    end
    interval
  end
end
