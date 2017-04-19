class CreateProjectDefaultWatchers < ActiveRecord::Migration
  def change
    create_table :project_default_watchers do |t|
      t.belongs_to :project
      t.string :watchable_type
      t.text :user_ids

      t.timestamps null: false
    end

    add_index :project_default_watchers, :project_id, unique: true
  end
end
