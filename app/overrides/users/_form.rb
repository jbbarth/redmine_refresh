Deface::Override.new :virtual_path  => 'users/_form',
                     :name          => 'add-refresh-interval-to-users-form',
                     :insert_after  => "fieldset:has(erb[loud]:contains('call_hook(:view_users_form, '))",
                     :partial       => 'redmine_refresh/refresh_interval'
