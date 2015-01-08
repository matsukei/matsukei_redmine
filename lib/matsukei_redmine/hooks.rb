module MatsukeiRedmine
  class ApplicationHooks < Redmine::Hook::ViewListener
    render_on :view_layouts_base_html_head, partial: 'hooks/html_head'
  end
end
