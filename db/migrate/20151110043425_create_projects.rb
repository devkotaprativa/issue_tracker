class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :project_name
      t.datetime :start_date
      t.datetime :target_end_date
      t.datetime :final_end_date
      t.string :created_by

      t.timestamps null: false
    end
  end
end
