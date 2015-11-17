class Issue < ActiveRecord::Base
  belongs_to :project
  enum status: [:pending, :processing, :completed]
  enum priority: [:Low, :Normal, :High]
  has_many :user_issues
  has_many :users, through: :user_issues


end
