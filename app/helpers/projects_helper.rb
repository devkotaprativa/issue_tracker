module ProjectsHelper
	def created_by project
		project.created_by == current_user.id.to_s
	end
	
	def is_onprocess issue
		issue.status == "processing"		
	end

	def is_pending issue
		issue.status == "pending"
	end

	def is_assigned issue
		if issue.users.present?
			users = issue.users
			users.each do|u|
				if u.id == current_user.id
				end
			end
		else
			return false
		end
	end

	def date date
		date.to_date.to_formatted_s(:long_ordinal)
		
	end

	def is_assigned_to_project project, user_id
		user = Assignment.where(:user_id => user_id, :project_id => project.id)
		user.present?
	end
end
