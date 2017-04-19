RedmineApp::Application.routes.draw do
  controller :default_watcher_setting, as: 'default_watcher_setting' do
    put ':project_id/default_watcher/update', action: 'update', as: 'update'
  end
end
