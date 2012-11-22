require 'spec_helper'

describe "questions/show" do
  before(:each) do
    @question = assign(:question, stub_model(Question,
      :id => 1,
      :title => "Title",
      :reference => "Reference",
      :content => "MyText",
      :user_id => 2,
      :approved => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Title/)
    rendered.should match(/Reference/)
    rendered.should match(/MyText/)
    rendered.should match(/2/)
    rendered.should match(/false/)
  end
end
