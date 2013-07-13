namespace :db do
	desc "Populate database with nice smaple data"
	task :populate => :environment do
    require 'populator'
    require 'forgery'

    Coordinator.populate 5 do |coord|
    	coord.name = Forgery::Name.full_name
    	coord.about = Populator.sentences(1..2)
    	coord.location = Forgery::Address.state
    	coord.contact = Forgery::Internet.email_address
    	Event.populate 0..20 do |event|
    		event.name = Populator.words(1..3).titleize
    		event.about = Populator.sentences(1..2)
    		event.coordinator_id = coord.id 
    		event.location = Forgery::Address.state
    		random_date = Forgery::Date.date
    		event.start = random_date
    		event.end = random_date + rand(3)
    		Team.populate 0..20 do |team|
    			team.name = Populator.words(1..3).titleize
    			team.event_id = event.id 
    		end # /team
    	end # /event
    end # /coord
  end	
end