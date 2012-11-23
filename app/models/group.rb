class Group < ActiveRecord::Base
  attr_accessible :description, :name

  has_and_belongs_to_many :users
  has_many :questions
end
