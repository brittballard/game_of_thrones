require 'spec_helper'

describe Charecter do
	before do
		@ned = FactoryGirl.build(:charecter)
	end

	subject { @ned }

	it 'should be valid' do
		subject.valid?.should be_true	
	end

	it { should respond_to :first_name }
	it { should respond_to :last_name }
	it { should respond_to :sex }
	it { should respond_to :mother }
	it { should respond_to :father }
	it { should respond_to :children }

	it 'should require sex be either M or F' do
		subject.sex = "G"
		subject.valid?.should be_false
		subject.errors.keys.should include(:sex)
	end

	it 'should require first_name' do
		subject.first_name = ""
		subject.valid?.should be_false
		subject.errors.keys.should include(:first_name)
	end

	it 'should require last_name' do
		subject.last_name = ""
		subject.valid?.should be_false
		subject.errors.keys.should include(:last_name)
	end
end

describe Charecter, '#children' do
	it 'should return all of the children the charecter has' do
		ned = FactoryGirl.create(:charecter)
		jon = FactoryGirl.create(:charecter, first_name: "Jon", father: ned)
	
		ned.children.should include jon
	end
end

describe Charecter, 'validation' do
	before :each do
		@ned = FactoryGirl.create(:charecter)
		@arya = FactoryGirl.build(:charecter, first_name: "Arya", last_name: "Stark")
	end
	
	describe Charecter, '#validate_parent_is_not_a_child' do
		it 'should not allow a charecter to be saved with the same model as a mother and a child' do
			@arya.father = @ned
			@arya.save!

			@ned.mother = @arya

			@ned.valid?.should be_false

			@ned.errors.size.should == 1
	  	@ned.errors.messages[:mother].should == ["A charecter's child cannot also be its mother"]
	  end

	  it 'should not allow a charecter to be saved with the same model as a father and a child' do
			@arya.father = @ned
			@arya.save!

			@ned.father = @arya

			@ned.valid?.should be_false

			@ned.errors.size.should == 1
	  	@ned.errors.messages[:father].should == ["A charecter's child cannot also be its father"]
	  end
	end

	describe Charecter, '#validate_mother_and_father_are_not_the_same_charecter' do
	  it 'should not allow a charecter to be saved with the same charecter as its mother and father' do
			@arya.save!

			@ned.father = @arya
			@ned.mother = @arya

			@ned.valid?.should be_false

			@ned.errors.size.should == 2
	  	@ned.errors.messages[:mother].should == ["A charecter's mother and father cannot be the same charecter"]
	  	@ned.errors.messages[:father].should == ["A charecter's mother and father cannot be the same charecter"]
	  end
	end

	describe Charecter, '#validate_that_a_charecter_is_not_its_own_parent' do
	  it 'should not allow a charecter to be its own father' do
			@ned.father = @ned

			@ned.valid?.should be_false

			@ned.errors.size.should == 1
	  	@ned.errors.messages[:father].should == ["A charecter cannot be its own father"]
	  end

		it 'should not allow a charecter to be its own mother' do
			@ned.mother = @ned

			@ned.valid?.should be_false

			@ned.errors.size.should == 1
	  	@ned.errors.messages[:mother].should == ["A charecter cannot be its own mother"]
	  end
	end
end