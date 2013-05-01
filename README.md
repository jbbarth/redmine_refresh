Redmine Refresh plugin
======================

This plugins adds an automatic refresh on "Issues" lists and "My Page".

Screenshot
----------

With this plugin you'll have a clickable link on these pages for enabling/disabling automatic refresh. Here's an example on an Issues list:

![redmine_refresh screenshot](http://jbbarth.com/screenshots/redmine_refresh.png)

Installation
------------

This plugin is compatible with Redmine 2.1.x and 2.2.x, and should be compatible with future versions.

Add this line to your redmine's Gemfile.local:

    gem 'redmine_refresh'

And then execute:

    $ bundle install

And restart your Redmine instance.

This gem aims at working inside a Redmine instance. Any other usage is discouraged.

Note that general instructions for plugins [here](http://www.redmine.org/wiki/redmine/Plugins) don't apply here.


Contributing
------------

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
