Feature: List all teams associated with a user
	In order to understand what teams are associated
	As a registered user of the site
	I want be shown teams that I am affiliated with in a smart way.

	Scenario: See teams associated with me
		Given that I am a member of the site
		And I have teams
		When I visit the teams page
		Then I should see teams I am associated with

	Scenario: Show friendly message when there are no teams
		Given that I am a member of the site
		And I have no teams
		When I visit the teams page
		Then I should see a message alerting me there are no teams

	Scenario: Show active teams first
		Given that I am a member of the site
		And I have teams
		And Some teams are associated with past events
		When I visit the teams page
		Then I should see active teams listed first