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
    end

  end
end

ProjectsHelper.send :include, MatsukeiRedmine::ProjectsHelperPatch
