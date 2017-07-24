Deface::Override.new :virtual_path  => 'my/page',
                     :original      => '7b02b984dabd756a62959aeea9c05db9d378bf7a',
                     :name          => 'add-refresh-link-to-my-page',
                     :insert_top    => 'div.contextual',
                     :partial       => 'redmine_refresh/refresher'

Deface::Override.new :virtual_path  => 'my/custom_page',
                     :original      => '7b02b984dabd756a62959aeea9c05db9d378bf7a',
                     :name          => 'add-refresh-link-to-my-custom-page',
                     :insert_top    => 'div.contextual',
                     :partial       => 'redmine_refresh/refresher'
