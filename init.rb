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
