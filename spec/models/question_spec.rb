require 'spec_helper'

describe Question do
  before :each do
    @user = FactoryGirl.create :user
    @answers = FactoryGirl.create_list :answer, 2, user: @user
  end

  it "destroy associated answers on delete" do
    @answers.first.question.destroy
    expect(@user.answers.count).to be(1)
  end
end
