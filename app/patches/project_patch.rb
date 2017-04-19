require_dependency 'project'

module MatsukeiRedmine
  module ProjectPatch
    unloadable

    extend ActiveSupport::Concern

    included do
      unloadable

      has_many :default_watchers, dependent: :destroy, class_name: 'ProjectDefaultWatcher'
    end

  end
end

MatsukeiRedmine::ProjectPatch.tap do |mod|
  Project.send :include, mod unless Project.include?(mod)
end
