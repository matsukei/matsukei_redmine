module MatsukeiRedmine
  class IssueViewHook < Redmine::Hook::ViewListener
    render_on :view_issues_form_details_bottom, partial: "issues/default_watcher"
  end
end
