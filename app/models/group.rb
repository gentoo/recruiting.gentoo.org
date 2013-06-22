class Group < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :questions
  has_many :user_groups
  has_many :users, through: :user_groups

  has_many :ready_users

  %w(developer staffer arch_tester).each do |grp|
    instance_eval <<-EOH
      def #{grp}
        where(["name like ?", "#{grp}%"]).first
      end
    EOH
  end
end
