Deface::Override.new :virtual_path  => 'issues/index.html',
                     :name          => 'add-refresh-link-to-issues-list',
                     :insert_top    => 'div.contextual',
                     :partial       => 'redmine_refresh/refresher'
