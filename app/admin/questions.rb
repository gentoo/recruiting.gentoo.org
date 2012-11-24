ActiveAdmin.register Question do
  config.batch_actions = true

  scope :approved, default: true do |questions|
    questions.where(workflow_state: "approved")
  end

  scope :awaiting_review do |questions|
    questions.where(workflow_state: "new")
  end

  scope :rejected do |questions|
    questions.where(workflow_state: "rejected")
  end

  index do
    selectable_column
    column :title
    column ("Content") {|question| truncate(question.content, length: 200) }
    column("Status") { |question| status_tag(question.current_state.to_s) }
    column :created_at
    default_actions
  end

  show do |question|
    attributes_table do
      row :title
      row :content do
        markdown question.content
      end
      row :group
      row :category
      row :created_at
      row :updated_at
      row("Action") do
        unless question.approved?
          span class: "action_item" do
            link_to "Approve", "/admin/questions/#{question.id}/approve", method: :put
          end
          span class: "action_item" do
            link_to "Reject", "/admin/questions/#{question.id}/reject", method: :put
          end
        end
      end
    end
  end

  form do |f|
    f.inputs "Info" do
      f.input :title
      f.input :content
      f.input :group
    end
    f.buttons
  end

  member_action :approve, :method => :put do
    question = Question.find params[:id]
    question.approve!
    flash[:notice] = "#{question.title} approved!"
    redirect_to action: :index
  end

  member_action :reject, :method => :put do
    question = Question.find params[:id]
    question.reject!
    flash[:notice] = "#{question.title} rejected!"
    redirect_to action: :index
  end
end
