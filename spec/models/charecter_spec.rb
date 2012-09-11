require 'spec_helper'

describe Charecter do
	before do
		@ned = FactoryGirl.build(:charecter)
	end

	subject { @ned }

	it 'should be valid' do
		subject.valid?.should be_true	
	end

	it { should respond_to :is_bastard }
	it { should respond_to :first_name }
	it { should respond_to :last_name }
	it { should respond_to :sex }
	it { should respond_to :mother }
	it { should respond_to :father }
	it { should respond_to :children }
	it { should respond_to :bastards }
	it { should respond_to :high_born_children }

	it 'should require sex be either M or F' do
		subject.sex = "G"
		subject.valid?.should be_false
		subject.errors.keys.should include(:sex)
	end

	it 'should require first_name' do
		subject.first_name = nil
		subject.valid?.should be_false
		subject.errors.keys.should include(:first_name)
	end

	it 'should require last_name' do
		subject.last_name = nil
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

	it 'should return as many rows as the sum of bastards + high_born_children' do
		ned = FactoryGirl.create(:charecter)
		jon = FactoryGirl.create(:charecter, first_name: "Jon", father: ned, is_bastard: true)
		robb = FactoryGirl.create(:charecter, first_name: "Robb", father: ned)
		bran = FactoryGirl.create(:charecter, first_name: "Bran", father: ned)
		rikon = FactoryGirl.create(:charecter, first_name: "Rikon", father: ned)
		arya = FactoryGirl.create(:charecter, first_name: "Arya", father: ned)
		sansa = FactoryGirl.create(:charecter, first_name: "Sansa", father: ned)

		ned.children.size.should == ned.bastards.size + ned.high_born_children.size	
	end
end

describe Charecter, '#high_born_children' do
	it 'should return a list of all the charecter\'s children that are not bastards' do
		ned = FactoryGirl.create(:charecter)
		jon = FactoryGirl.create(:charecter, first_name: "Jon", father: ned, is_bastard: true)
		robb = FactoryGirl.create(:charecter, first_name: "Robb", father: ned)

		ned.high_born_children.size.should == 1
		ned.high_born_children.should include(robb)
	end	
end

describe Charecter, '#bastards' do
	it 'should return a list of all the charecter\'s children that are bastards' do
		ned = FactoryGirl.create(:charecter)
		jon = FactoryGirl.create(:charecter, first_name: "Jon", father: ned, is_bastard: true)
		robb = FactoryGirl.create(:charecter, first_name: "Robb", father: ned)

		ned.bastards.size.should == 1
		ned.bastards.should include(jon)
	end
end

describe Charecter, '#add_child' do
	it 'should set the child\'s father to the charecter if the charecter is male' do
		ned = FactoryGirl.create(:charecter)
		robb = FactoryGirl.build(:charecter, first_name: "Robb")
		ned.add_child(robb)

		robb.father.should == ned
	end

	it 'should set the child\'s mother to the charecter if the charecter is female' do
		catalyn = FactoryGirl.create(:charecter, first_name: "Catalyn", sex: "F")
		robb = FactoryGirl.build(:charecter, first_name: "Robb")
		catalyn.add_child(robb)

		robb.mother.should == catalyn
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