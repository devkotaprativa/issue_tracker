module ApplicationHelper
	def resource_name
    :user
  end

  def resource_class 
     User 
  end

  def resource
    @resource ||= User.new
    
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def is_assigned_to_issue issue, user_id
    user = UserIssue.where(:user_id => user_id, :issue_id => issue.id)
    user.present?
  end
end
