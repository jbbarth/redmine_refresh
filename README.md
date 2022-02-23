Redmine Refresh plugin
======================

This plugins adds an automatic refresh on "Issues" lists and "My Page".

Screenshot
----------

With this plugin you'll have a clickable link on these pages for enabling/disabling automatic refresh. Here's an example on an Issues list:

![redmine_refresh screenshot](http://jbbarth.com/screenshots/redmine_refresh.png)

Install
-------

This plugin is compatible with Redmine 2.1.x and 2.2.x, and should be compatible with future versions.

You can first take a look at general instructions for plugins [here](http://www.redmine.org/wiki/redmine/Plugins).

Then :
* install the redmine_base_deface plugin (see [here](https://github.com/jbbarth/redmine_base_deface))
* clone this repository in your "plugins/" directory ; if you have a doubt you put it at the good level, you can check you have a plugins/redmine_refresh/init.rb file
* install dependencies (gems) by running `bundle install` from the root of your redmine instance
* restart your Redmine instance (depends on how you host it)

Test status
------------

|Plugin branch| Redmine Version   | Test Status      |
|-------------|-------------------|------------------|
|master       | 4.2.4             | [![4.2.4][1]][5] |  
|master       | 4.1.6             | [![4.1.6][2]][5] |
|master       | master            | [![master][4]][5]|

[1]: https://github.com/jbbarth/redmine_refresh/actions/workflows/4_2_4.yml/badge.svg
[2]: https://github.com/jbbarth/redmine_refresh/actions/workflows/4_1_6.yml/badge.svg
[4]: https://github.com/jbbarth/redmine_refresh/actions/workflows/master.yml/badge.svg
[5]: https://github.com/jbbarth/redmine_refresh/actions

Contribute
----------

If you like this plugin, it's a good idea to contribute :
* by giving feed back on what is cool, what should be improved
* by reporting bugs : you can open issues directly on github
* by forking it and sending pull request if you have a patch or a feature you want to implement
