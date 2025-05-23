require_dependency 'users_controller'

module RedmineRefresh
  module UsersControllerPatch
    def self.included(base) # :nodoc:
      base.extend(ClassMethods)
      base.send(:include, InstanceMethods)

      base.class_eval do
        after_action :save_helpdesk_preferences
      end
    end

    module ClassMethods
    end

    module InstanceMethods
      def save_helpdesk_preferences
        if @user.present? && request.method == "POST" && flash[:notice] == l(:notice_successful_update)
          @user.pref[:refresh_interval] = (request.params[:refresh] && request.params[:refresh][:refresh_interval] ? request.params[:refresh][:refresh_interval] : '120').to_i
          @user.pref.save
        end
      end
    end
  end
end

UsersController.send(:include, RedmineRefresh::UsersControllerPatch) unless UsersController.included_modules.include? RedmineRefresh::UsersControllerPatch
