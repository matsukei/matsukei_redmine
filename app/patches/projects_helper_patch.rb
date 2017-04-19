require_dependency 'projects_helper'

module MatsukeiRedmine
  module ProjectsHelperPatch
    unloadable

    extend ActiveSupport::Concern

    included do
      def events_last_updated_on(project)
        events = []
        events << project.issues.last
        events << project.issue_changes.last
        events << project.changesets.last
        events << project.documents.last
        events << project.news.last
        events.compact!

        events.sort! {|a, b| b.event_datetime <=> a.event_datetime}
        events.first.try(:event_datetime)
      end

      alias_method_chain :project_settings_tabs, :default_watcher_setting_tab
    end

    def project_settings_tabs_with_default_watcher_setting_tab
      tabs = project_settings_tabs_without_default_watcher_setting_tab

      tabs << {
        name: 'default_watcher',
        action: :manage_default_watcher,
        partial: 'default_watcher_setting/form',
        label: :'default_watcher.label_setting'
      }

      tabs
    end

  end
end

ProjectsHelper.send :include, MatsukeiRedmine::ProjectsHelperPatch
