class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :title
      t.text :description
      t.integer :priority
      t.date :deadline
      t.integer :status
      t.references :project, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
