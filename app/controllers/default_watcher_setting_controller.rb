class DefaultWatcherSettingController < ApplicationController
  unloadable

  before_filter :find_project_by_project_id

  def update
    settings = params[:settings]

    ActiveRecord::Base.transaction do
      settings.each do |watchable_type, user_ids|
        default_watcher = @project.default_watchers.find_or_initialize_by(
          project_id: @project.id, watchable_type: watchable_type.to_s.classify)
        default_watcher.user_ids = user_ids

        default_watcher.save!
      end
    end

    render partial: 'form'
  end
end
