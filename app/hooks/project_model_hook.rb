module MatsukeiRedmine
  class ProjectModelHooks < Redmine::Hook::ViewListener
    def model_project_copy_before_save(context = {})
      source_project, destination_project = context.values_at :source_project, :destination_project

      unless User.current.allowed_to?(:manage_members, destination_project)
        role = Role.find_all_givable.to_a.find { |role| role.allowed_to?(:manage_members) }
        if role.present?
          if User.current.member_of?(destination_project)
            project_member = destination_project.members.where(user_id: User.current.id).first
            project_member.role_ids = project_member.roles.pluck(:id) + [role.id]
            project_member.save
          else
            destination_project.members.create(role_ids: [ role.id ], user_id: User.current.id)
          end
        end
      end

    end
  end
end
