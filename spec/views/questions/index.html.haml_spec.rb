require 'spec_helper'

describe "questions/index" do
  before(:each) do
    assign(:questions, [
      stub_model(Question,
        :id => 1,
        :title => "Title",
        :reference => "Reference",
        :content => "MyText",
        :user_id => 2,
        :approved => false
      ),
      stub_model(Question,
        :id => 1,
        :title => "Title",
        :reference => "Reference",
        :content => "MyText",
        :user_id => 2,
        :approved => false
      )
    ])
  end

  it "renders a list of questions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Reference".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
