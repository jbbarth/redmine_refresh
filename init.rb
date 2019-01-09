require 'redmine'

ActiveSupport::Reloader.to_prepare do
  require_dependency 'redmine_refresh'
end

Redmine::Plugin.register :redmine_refresh do
  name 'Redmine Refresh plugin'
  description 'This is a plugin for Redmine'
  url 'https://github.com/jbbarth/redmine_refresh'
  author 'Jean-Baptiste BARTH'
  author_url 'mailto:jeanbaptiste.barth@gmail.com'
  version '0.2.0'
  requires_redmine :version_or_higher => '2.1.0'
  requires_redmine_plugin :redmine_base_rspec, :version_or_higher => '0.0.4' if Rails.env.test?
  requires_redmine_plugin :redmine_base_deface, :version_or_higher => '0.0.1'
  #settings :default => { }, :partial => 'settings/sudo_settings'
end
