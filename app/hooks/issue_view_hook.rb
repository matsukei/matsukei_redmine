module MatsukeiRedmine
  class IssueViewHook < Redmine::Hook::ViewListener
    render_on :view_issues_form_details_bottom, partial: "issues/default_watcher"
    render_on :view_issues_sidebar_queries_bottom, partial: "issues/notified_users"
  end
end
