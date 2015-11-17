module ProjectsHelper
	def created_by project
		project.created_by == current_user.id.to_s
	end
	

end
