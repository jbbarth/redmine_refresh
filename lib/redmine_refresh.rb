require_relative 'redmine_refresh/my_controller_patch'
require_relative 'redmine_refresh/users_controller_patch'

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

  class Hooks < Redmine::Hook::ViewListener
    def view_my_account(context = {})
      begin
        return %(
          </fieldset>
          <fieldset class="box tabular">
          <legend>#{l(:label_refresh)}</legend>
          <p>
            #{label_tag "refresh_interval", l(:label_refresh_interval)}
            #{text_field :refresh, :refresh_interval, :value => (User.current.pref[:refresh_interval].nil? ? DEFAULT_INTERVAL : User.current.pref[:refresh_interval]).to_i}
          </p>
        )
      rescue => e
        Rails.logger.error e
        return "<pre>#{e}</pre>"
      end
    end

    def view_users_form(context = {})
      begin
        return %(
          </fieldset>
          <fieldset class="box tabular">
          <legend>#{l(:label_refresh)}</legend>
          <p>
            #{label_tag "refresh_interval", l(:label_refresh_interval)}
            #{text_field :refresh, :refresh_interval, :value => (context[:user].pref[:refresh_interval].nil? ? DEFAULT_INTERVAL : context[:user].pref[:refresh_interval]).to_i}
          </p>
        )
      rescue => e
        Rails.logger.error e
        return "<pre>#{e}</pre>"
      end
    end
  end
end
