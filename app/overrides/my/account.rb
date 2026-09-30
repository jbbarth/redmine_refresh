Deface::Override.new :virtual_path  => 'my/account',
                     :name          => 'add-refresh-interval-to-my-account',
                     :insert_after  => "fieldset:has(erb[loud]:contains('call_hook(:view_my_account, '))",
                     :partial       => 'redmine_refresh/refresh_interval'
