module RedmineRefresh

  class ModelHook < Redmine::Hook::Listener
    def after_plugins_loaded(_context = {})
      require_relative '../redmine_refresh'
    end
  end

end
