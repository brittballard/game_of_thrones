require 'spec_helper'

describe "charecters/show" do
  before(:each) do
    @charecter = assign(:charecter, stub_model(Charecter,
      :first_name => "First Name",
      :last_name => "Last Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/First Name/)
    rendered.should match(/Last Name/)
  end
end
