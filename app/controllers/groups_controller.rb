class GroupsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @groups = Group.all
  end

  def subscribe
    authorize! :subscribe, Group
    group = Group.find(params[:id])
    if current_user.group.nil? && group.present?
      current_user.update_attribute(:group_id, params[:id])
      flash[:notice] = "You have subscribed to group #{group.name}"
      redirect_to [group, :questions]
    else
      flash[:alert] = "You can only subscribe to one group at a time."
      redirect_to [group, :questions]
    end
  end
end
