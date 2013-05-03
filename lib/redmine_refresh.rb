require "deface"
require "redmine_refresh/version"

module RedmineRefresh
  # Run the classic redmine plugin initializer after rails boot
  class Plugin < ::Rails::Engine
    config.after_initialize do
      require File.expand_path("../../init", __FILE__)
    end
  end

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

  #if should_be_refreshed != RedmineRefresh.refresh_status_for_controller(controller.controller_name)
  def refresh_status_for_controller(user, controller = nil)
    controller = controller.to_s
    controller.present? && user.pref[:refresh_status].is_a?(Hash) && user.pref[:refresh_status][controller]
  end

  def save_refresh_status_for_controller(user, controller, current_refresh_status)
    user_refresh_status = refresh_status_for_controller(user, controller)
    controller = controller.to_s
    if controller.present? && user_refresh_status != current_refresh_status
      user.pref[:refresh_status] ||= Hash.new
      user.pref[:refresh_status][controller] = current_refresh_status
      user.pref.save
    end
  end
end
