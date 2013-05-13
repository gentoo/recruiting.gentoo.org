require 'spec_helper'

describe Answer do
  context "answers by the same user" do
    before :each do
      @user = FactoryGirl.create :user
      @answers = FactoryGirl.create_list :answer, 2, user: @user
    end

    it "should point to next answer" do
      @answers.first.next.id.should == @answers.last.id
      @answers.last.next.should be_nil
    end

    it "should point to previuos answer" do
      @answers.first.previous.should be_nil
      @answers.last.previous.id.should == @answers.first.id
    end
  end
end
