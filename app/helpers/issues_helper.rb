module IssuesHelper
	
	def is_assigned_to_issue issue, user_id
		user = UserIssue.where(:user_id => user_id, :issue_id => issue.id)
		user.present?
	end
end
