require_dependency 'projects_controller'

module MatsukeiRedmine
  module ProjectsControllerPatch
    unloadable

    extend ActiveSupport::Concern

    included do
      unloadable

      before_filter :require_admin, only: [ :archive, :unarchive, :destroy ]
    end

  end
end

ProjectsController.send :include, MatsukeiRedmine::ProjectsControllerPatch
