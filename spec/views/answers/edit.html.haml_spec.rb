require 'spec_helper'

describe "answers/edit" do
  before(:each) do
    @answer = assign(:answer, stub_model(Answer,
      :question_id => 1,
      :user_id => 1,
      :content => "MyText",
      :status => "MyString"
    ))
  end

  it "renders the edit answer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => answers_path(@answer), :method => "post" do
      assert_select "input#answer_question_id", :name => "answer[question_id]"
      assert_select "input#answer_user_id", :name => "answer[user_id]"
      assert_select "textarea#answer_content", :name => "answer[content]"
      assert_select "input#answer_status", :name => "answer[status]"
    end
  end
end
