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

    it "should point to rejected answers" do
      rejected_answers = Answer.rejected_answers(@user)
      expect(rejected_answers.length).to eq 0
      a_rejected_answer = FactoryGirl.create :answer, user: @user
      a_rejected_answer.workflow_state = 'rejected'
      a_rejected_answer.save
      rejected_answers = Answer.rejected_answers(@user)
      expect(rejected_answers.length).to eq 1
      expect(rejected_answers.include?(a_rejected_answer)).to be true
      another_rejected_answer = FactoryGirl.create :answer, user: @user
      another_rejected_answer.workflow_state = 'rejected'
      another_rejected_answer.save
      rejected_answers = Answer.rejected_answers(@user)
      expect(rejected_answers.length).to eq 2
      expect(rejected_answers.include?(a_rejected_answer)).to be true
      expect(rejected_answers.include?(another_rejected_answer)).to be true
    end
  end
end
