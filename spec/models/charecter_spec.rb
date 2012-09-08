require 'spec_helper'

describe Charecter, '#children' do
	it 'should return all of the children the charecter has' do
		ned = FactoryGirl.create(:charecter)
		jon = FactoryGirl.create(:charecter, first_name: "Jon", father: ned)

		ned.children.should include jon
	end
end

describe Charecter, '#validate_parent_is_not_a_child' do
	before :each do
		@ned = FactoryGirl.create(:charecter)
		@arya = FactoryGirl.build(:charecter, first_name: "Arya", last_name: "Stark")
	end

	it 'should not allow a charecter to be saved with the same model as a mother and a child' do
		@arya.father = @ned
		@arya.save!

		@ned.mother = @arya

		@ned.valid?

		@ned.errors.size.should == 1
  	@ned.errors.messages[:mother].should == ["A charecter's child cannot also be its mother"]
  end

  it 'should not allow a charecter to be saved with the same model as a father and a child' do
		@arya.father = @ned
		@arya.save!

		@ned.father = @arya

		@ned.valid?

		@ned.errors.size.should == 1
  	@ned.errors.messages[:father].should == ["A charecter's child cannot also be its father"]
  end

  it 'should not allow a charecter to be saved with the same charecter as its mother and father' do
		@arya.save!

		@ned.father = @arya
		@ned.mother = @arya

		@ned.valid?

		@ned.errors.size.should == 2
  	@ned.errors.messages[:mother].should == ["A charecter's mother and father cannot be the same charecter"]
  	@ned.errors.messages[:father].should == ["A charecter's mother and father cannot be the same charecter"]
  end

  it 'should not allow a charecter to be its own father' do
		@ned.father = @ned

		@ned.valid?

		@ned.errors.size.should == 1
  	@ned.errors.messages[:father].should == ["A charecter cannot be its own father"]
  end

	it 'should not allow a charecter to be its own mother' do
		@ned.mother = @ned

		@ned.valid?

		@ned.errors.size.should == 1
  	@ned.errors.messages[:mother].should == ["A charecter cannot be its own mother"]
  end
end
