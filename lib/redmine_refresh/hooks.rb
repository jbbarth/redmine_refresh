module RedmineRefresh

  class Hooks < Redmine::Hook::ViewListener
    def view_layouts_base_html_head(context)
      stylesheet_link_tag("redmine_refresh", :plugin => "redmine_refresh")
    end
  end

  class ModelHook < Redmine::Hook::Listener
    def after_plugins_loaded(_context = {})
      require_relative '../redmine_refresh'
    end
  end

end
