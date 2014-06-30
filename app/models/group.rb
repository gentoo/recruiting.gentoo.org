class Group < ActiveRecord::Base
  attr_accessible :description, :name
  acts_as_paranoid

  has_many :questions, dependent: :destroy
  has_many :user_groups
  has_many :users, through: :user_groups

  has_many :ready_users, dependent: :destroy

  %w(developer staffer arch_tester).each do |grp|
    instance_eval <<-EOH
      def #{grp}
        where(["name like ?", "#{grp}%"]).first
      end
    EOH
  end
end
