require 'spec_helper'

describe "charecters/new" do
  before(:each) do
    assign(:charecter, stub_model(Charecter,
      :first_name => "MyString",
      :last_name => "MyString"
    ).as_new_record)
  end

  it "renders new charecter form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => charecters_path, :method => "post" do
      assert_select "input#charecter_first_name", :name => "charecter[first_name]"
      assert_select "input#charecter_last_name", :name => "charecter[last_name]"
    end
  end
end
