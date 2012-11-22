ActiveAdmin.register User do
  scope :all, default: true
  scope :novices do |users|
    users.where(workflow_state: "novice")
  end

  scope :candidates do |users|
    users.where(workflow_state: "candidate")
  end

  scope :developers do |users|
    users.where(workflow_state: "developer")
  end

  scope :mentors do |users|
    users.where(workflow_state: "mentor")
  end

  scope :recruiters do |users|
    users.where(workflow_state: "recruiter")
  end

  scope :admins do |users|
    users.where(workflow_state: "admin")
  end

  index do
    column("Name", :name)
    column("Email", :email)
    column("Role") { |user| status_tag(user.current_state.to_s) }
    column("Action") { |user| link_to "Promote", promote_path(user)}
    default_actions
  end
end
