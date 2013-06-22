class ReadyUser < ActiveRecord::Base
  attr_accessible :user_id, :group_id, :recruited

  belongs_to :user
  belongs_to :group

  # The badge earned by passing the tests
  def badge
    group.name.sub(/\sQuiz/, '')
  end

  def recruit!
    self.update_attribute(:recruited, true)
  end

  %w(developer staffer arch_tester).each do |grp| 
    instance_eval <<-EOH
      def #{grp}s
        self.includes(:user).where(group_id: Group.#{grp}.id)
      end
    EOH
  end
end
