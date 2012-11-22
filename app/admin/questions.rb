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
    column :content
    column("Status") { |question| status_tag(question.current_state.to_s) }
    column :created_at
    default_actions
  end

  form do |f|
    f.inputs "Info" do
      f.input :title
      f.input :content
      f.input :group
      f.input :category
    end
    f.buttons
  end

end
