class GroupsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @groups = Group.all
  end

  def subscribe
    authorize! :subscribe, Group
    group = Group.find(params[:id])
    current_user.groups += [group]
    flash[:notice] = "You have subscribed to group #{group.name}"
    redirect_to [group, :questions]
  end

  def unsubscribe
    authorize! :subscribe, Group
    group = current_user.groups.find(params[:id])
    if group
      current_user.groups.delete(group)
    end
    redirect_to action: :index
  end
end
