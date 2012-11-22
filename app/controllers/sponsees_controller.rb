class SponseesController < ApplicationController
  def index
    @sponsees = current_user.sponsees
  end

  def show
  end
end
