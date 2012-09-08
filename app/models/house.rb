class House < ActiveRecord::Base
	def self.sigils
		%w(dire\ wolf lion)
	end	

	validates :sigil, 	:inclusion => { :in => sigils }
	validates :name, :motto, :sigil, :presence => true

  attr_accessible :motto, :name, :sigil
end
