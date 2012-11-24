ActiveAdmin.register Project do
  
  form do |f|
    f.inputs "Project" do
      f.input :name
      f.input :description
      f.input :groups, as: :check_boxes
      f.input :team_members, as: :check_boxes
    end
    f.buttons
  end

  index do
    column :name
    column :parent_project
    column :groups
    column :homepage
    column :leaders
    column :members
    default_actions
  end
end
