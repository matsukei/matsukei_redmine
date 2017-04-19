require_dependency 'application_helper'

module MatsukeiRedmine
  module ApplicationHelperPatch
    unloadable

    extend ActiveSupport::Concern

    included do
      alias_method_chain :render_project_jump_box, :parent

      def project_tree_options_for_select_with_parent(projects, options, &block)
        # See: lib\redmine\nested_set\traversing.rb
        project_ids = projects.map { |project| project.self_and_ancestors.pluck(:id) }
        projects = Project.active.visible.where(
          id: project_ids.flatten.compact.uniq).select(
          :id, :name, :identifier, :lft, :rgt).to_a

        project_tree_options_for_select(projects, options, &block)
      end

    end

    # Renders the project quick-jump box
    def render_project_jump_box_with_parent
      return unless User.current.logged?
      projects = User.current.projects.active.select(:id, :name, :identifier, :lft, :rgt).to_a
      if projects.any?
        options =
          ("<option value=''>#{ l(:label_jump_to_a_project) }</option>" +
           '<option value="" disabled="disabled">---</option>').html_safe

        options << project_tree_options_for_select_with_parent(projects, :selected => @project) do |p|
          { :value => project_path(:id => p, :jump => current_menu_item) }
        end

        content_tag( :span, nil, :class => 'jump-box-arrow') +
        select_tag('project_quick_jump_box', options, :onchange => 'if (this.value != \'\') { window.location = this.value; }')
      end
    end

  end
end

ApplicationHelper.send :include, MatsukeiRedmine::ApplicationHelperPatch
