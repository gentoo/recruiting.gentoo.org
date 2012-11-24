ActiveAdmin.register User do
  menu priority: 1
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
    column("Action") { |user| link_to "Promote", "/admin/users/#{user.id}/promote", method: :put}
    default_actions
  end

  form do |f|
    f.inputs "user" do
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.buttons
  end

  member_action :promote, :method => :put do
    user = User.find(params[:id])
    user.promote!
    flash[:notice] = "#{user.name} promoted!"
    redirect_to action: :index
  end
end
