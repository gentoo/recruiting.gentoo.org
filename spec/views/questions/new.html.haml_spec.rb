require 'spec_helper'

describe "questions/new" do
  before(:each) do
    assign(:question, stub_model(Question,
      :id => 1,
      :title => "MyString",
      :reference => "MyString",
      :content => "MyText",
      :user_id => 1,
      :approved => false
    ).as_new_record)
  end

  it "renders new question form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => questions_path, :method => "post" do
      assert_select "input#question_id", :name => "question[id]"
      assert_select "input#question_title", :name => "question[title]"
      assert_select "input#question_reference", :name => "question[reference]"
      assert_select "textarea#question_content", :name => "question[content]"
      assert_select "input#question_user_id", :name => "question[user_id]"
      assert_select "input#question_approved", :name => "question[approved]"
    end
  end
end
