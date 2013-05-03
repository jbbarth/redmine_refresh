Redmine::Plugin.register :redmine_refresh do
  name 'Redmine Refresh plugin'
  description 'This is a plugin for Redmine'
  url 'https://github.com/jbbarth/redmine_refresh'
  author 'Jean-Baptiste BARTH'
  author_url 'mailto:jeanbaptiste.barth@gmail.com'
  #TODO: make it depend on redmine_refresh/version
  version '0.3.0'
  requires_redmine :version_or_higher => '2.1.0'
  #settings :default => { }, :partial => 'settings/sudo_settings'
end
