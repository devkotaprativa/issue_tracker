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
					return true
				else
					return false
				end
			end
		else
			return false
		end
	end
end
