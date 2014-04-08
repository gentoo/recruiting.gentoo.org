ActiveAdmin.register Question do
  config.batch_actions = true

  index do
    selectable_column
    #column :title
    column :group
    column ("Content") {|question| truncate(question.content, length: 200) }
    column :created_at
    default_actions
  end

  show do |question|
    attributes_table do
      #row :title
      row :content do
        markdown question.content
      end
      row :group
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs "Info" do
      #f.input :title
      f.input :content
      f.input :group
    end
    f.buttons
  end
end
