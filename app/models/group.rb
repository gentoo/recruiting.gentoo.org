class Group < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :questions
  has_many :user_groups
  has_many :users, through: :user_groups

end
