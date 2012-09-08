require 'spec_helper'

describe "charecters/edit" do
  before(:each) do
    @charecter = assign(:charecter, stub_model(Charecter,
      :first_name => "MyString",
      :last_name => "MyString"
    ))
  end

  it "renders the edit charecter form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => charecters_path(@charecter), :method => "post" do
      assert_select "input#charecter_first_name", :name => "charecter[first_name]"
      assert_select "input#charecter_last_name", :name => "charecter[last_name]"
    end
  end
end
