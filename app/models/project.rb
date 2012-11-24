class Project < ActiveRecord::Base
  store :team, accessors: [:members, :leaders]
  attr_accessible :description, :name, :homepage, :applying_project_id, :team_member_ids, :group_ids

  has_and_belongs_to_many :team_members, class_name: "User"
  has_and_belongs_to_many :groups
  has_many :candidates, class_name: "User", foreign_key: "applying_project_id"

  has_many :subprojects, class_name: "Project", foreign_key: :parent_prj_id
  belongs_to :parent_project, class_name: "Project", foreign_key: :parent_prj_id

  belongs_to :leader, class_name: "User"

  scope :top_level, where(parent_prj_id: nil)
  scope :subprojects, -> parent_id { where(parent_prj_id: parent_id) }
end
