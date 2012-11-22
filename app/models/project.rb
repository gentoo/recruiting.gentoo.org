class Project < ActiveRecord::Base
  attr_accessible :description, :name

  has_and_belongs_to_many :members, class_name: "User"

  has_many :subprojects, class_name: "Project", foreign_key: :parent_prj_id
  belongs_to :parent_project, class_name: "Project"

  belongs_to :leader, class_name: "User"
end
