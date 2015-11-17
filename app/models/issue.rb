class Issue < ActiveRecord::Base
  belongs_to :project
  enum status: [:pending, :on_process, :completed]
  enum priority: [:low, :normal, :high]


end
