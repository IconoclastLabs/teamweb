namespace :db do
	desc "Populate database with nice smaple data"
	task :populate => :environment do
    require 'populator'
    require 'forgery'

    # Create some users for login (if they don't already exist)
    users = []
    users << User.all.where(email: "gant@iconoclastlabs.com").first_or_create(password: "fdsafdsa")
    users << User.all.where(email: "themoke@gmail.com").first_or_create(password: "fdsafdsa")
    users << User.all.where(email: "daddymac@gmail.com").first_or_create(password: "fdsafdsa")

    Organization.populate 5 do |org|
    	org.name = Forgery::Name.full_name
    	org.about = Populator.sentences(1)
    	org.location = Forgery::Address.state
    	org.contact = Forgery::Internet.email_address
      # add owner
      random_user = users.sample
      #org.members.create(user_id: random_user.id, admin: true)

    	Event.populate 0..20 do |event|
    		event.name = Populator.words(1..3).titleize
    		event.about = Populator.sentences(1..2)
    		event.organization_id = org.id 
    		event.location = Forgery::Address.state
    		random_date = Forgery::Date.date
    		event.start = random_date
    		event.end = random_date + rand(3)
        #add owner
        random_user = users.sample
        #event.members.create(user_id: random_user.id, admin: true)

    		Team.populate 0..20 do |team|
    		  team.name = Populator.words(1..3).titleize
    		  team.event_id = event.id 
          #add owner
          random_user = users.sample
          #team.members.create(user_id: random_user.id, admin: true)  
    		end # /team
    	end # /event
    end # /org

  end	
end