Feature: managing charecters

Scenario: create a charecter
	Given I navigate to the new charecter screen
	When I enter ned's information
		|first_name	|last_name|
		|ned 				|stark		|
	And I submit the form
	Then I should find a new charecter