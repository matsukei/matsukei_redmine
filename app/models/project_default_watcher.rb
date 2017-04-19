class ProjectDefaultWatcher < ActiveRecord::Base
  unloadable

  WATCHABLE_TYPES = [ "Issue" ]

  belongs_to :project
  serialize :user_ids, Array

  validates :project_id, presence: true
  validates :watchable_type, inclusion: { in: WATCHABLE_TYPES }
end
