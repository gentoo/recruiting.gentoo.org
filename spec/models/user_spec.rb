require 'spec_helper'

describe User do
  describe "#ready?" do
    before :each do
      @user       = FactoryGirl.create :user
      @groups     = FactoryGirl.create_list :group, 2
      @questions  = @groups.collect { |group| FactoryGirl.create_list :question, 2, group: group }
    end

    it "should be false for user who didn't select any group yet" do
      @user.should_not be_ready
    end

    it "should be false if there are left some questions unanaswered in each group" do
      @user.groups = @groups
      @user.save!
      @questions.collect(&:first).each { |q| FactoryGirl.create :answer, user: @user, question: q }
      @user.should_not be_ready
    end

    it "should be false if someone else answered all questions" do
      user2 = FactoryGirl.create :user
      user2.groups = @user.groups = @groups
      user2.save!
      @user.save!
      @questions.flatten.each { |q| FactoryGirl.create :answer, user: user2, question: q }
      @user.should_not be_ready
    end

    it "should be true if user answered all question in one of groups" do
      @user.groups = @groups
      @user.save!
      @questions.flatten.each { |q| FactoryGirl.create :answer, user: @user, question: q }
      @user.should be_ready
    end
  end
end
