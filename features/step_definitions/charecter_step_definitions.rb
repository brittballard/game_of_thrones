Given /^I navigate to the new charecter screen$/ do
	visit(new_charecter_path)
end

When /^I enter ned's information$/ do |charecter_info|
  # charecter_info.hashes.each{ |charecter| puts "#{charecter[:first_name]} #{charecter[:last_name]}" }
  charecter_info.hashes.each do |charecter|
  	fill_in('First name', :with => charecter[:first_name])
  	fill_in('Last name', :with => charecter[:last_name])
  	select('M', :from => 'Sex')
  end
end


When /^I submit the form$/ do
	click_on('Create Charecter')
end

Then /^I should find a new charecter$/ do
	Charecter.all.size.should eq(1)
	page.has_content?('Charecter was successfully created.').should be_true
end