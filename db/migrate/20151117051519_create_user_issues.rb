class CreateUserIssues < ActiveRecord::Migration
  def change
    create_table :user_issues do |t|
      t.references :user, index: true, foreign_key: true
      t.references :issue, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
