class Project < ActiveRecord::Base
	validates :project_name, presence: true
	has_many :assignments
	has_many :users, through: :assignments
end
