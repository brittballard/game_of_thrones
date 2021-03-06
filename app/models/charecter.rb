class Charecter < ActiveRecord::Base
	validates :sex, :inclusion => { :in => %w(M F) }
	validates :first_name, :last_name, :presence => true
	validate :validate_parent_is_not_a_child, 
						:validate_mother_and_father_are_not_the_same_charecter, 
						:validate_that_a_charecter_is_not_its_own_parent

  attr_accessible :first_name, :last_name, :sex

  has_one :house
  belongs_to :mother, :class_name => "Charecter"
  belongs_to :father, :class_name => "Charecter"
  
	def children
		Charecter.where("#{get_mother_or_father_id_column} = ?", id)
	end

	def bastards
		Charecter.where("#{get_mother_or_father_id_column} = ? and is_bastard = 't'", id)
	end

	def high_born_children
		Charecter.where("#{get_mother_or_father_id_column} = ? and is_bastard = 'f'", id)
	end

	def add_child(child)
		child.father = self unless self.sex == 'F'
		child.mother = self unless self.sex == 'M'
	end

  def validate_parent_is_not_a_child
  	errors.add(:mother, "A charecter's child cannot also be its mother") if mother.present? && children.where("id = ?", mother.id).size > 0
  	errors.add(:father, "A charecter's child cannot also be its father") if father.present? && children.where("id = ?", father.id).size > 0
  end

  def validate_mother_and_father_are_not_the_same_charecter
  	if mother.present? && father.present? && mother.id == father.id
	  	errors.add(:mother, "A charecter's mother and father cannot be the same charecter")
	  	errors.add(:father, "A charecter's mother and father cannot be the same charecter")
  	end
  end

  def validate_that_a_charecter_is_not_its_own_parent
  	errors.add(:father, "A charecter cannot be its own father") if father.present? && father.id == id
  	errors.add(:mother, "A charecter cannot be its own mother") if mother.present? && mother.id == id
  end

  private

  	def get_mother_or_father_id_column
  		self.sex == "F" ? "mother_id" : "father_id"
  	end
end
