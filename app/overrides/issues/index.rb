Deface::Override.new :virtual_path  => 'issues/index',
                     :name          => 'add-refresh-link-to-issues-list',
                     :insert_bottom => 'div.contextual',
                     :partial       => 'redmine_refresh/refresher'