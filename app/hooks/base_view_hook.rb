module MatsukeiRedmine
  class BaseViewHooks < Redmine::Hook::ViewListener
    render_on :view_layouts_base_html_head, partial: 'layouts/base_head'
  end
end
