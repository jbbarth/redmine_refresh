# Little hack for using the 'deface' gem in redmine:
# - redmine plugins are not railties nor engines, so deface overrides in app/overrides/ are not detected automatically
# - deface doesn't support direct loading anymore ; it unloads everything at boot so that reload in dev works
# - hack consists in adding "app/overrides" path of the plugin in Redmine's main #paths
# TODO: see if it's complicated to turn a plugin into a Railtie or find something a bit cleaner
Rails.application.paths["app/overrides"] ||= []
Rails.application.paths["app/overrides"] << File.expand_path("../app/overrides", __FILE__)

Redmine::Plugin.register :redmine_refresh do
  name 'Redmine Refresh plugin'
  description 'This is a plugin for Redmine'
  author 'Jean-Baptiste BARTH'
  author_url 'mailto:jeanbaptiste.barth@gmail.com'
  url 'http://github.com/jbbarth/redmine_refresh'
  version '0.0.1'
  requires_redmine :version_or_higher => '2.0.0'
  #settings :default => { }, :partial => 'settings/sudo_settings'
end
