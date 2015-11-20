class Project < ActiveRecord::Base
	validates :project_name, presence: true
	has_many :assignments
	has_many :users, through: :assignments
	has_many :issues
	validates :project_name, :start_date, :target_end_date, presence: true
end

