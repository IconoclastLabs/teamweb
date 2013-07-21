namespace :db do
	desc "Populate database with nice smaple data"
	task :populate => :environment do
    require 'populator'
    require 'forgery'

    # Create some users for login (if they don't already exist)
    ensure_users

    Organization.populate 5 do |org|
    	org.name = Forgery::Name.full_name
    	org.about = Populator.sentences(1)
    	org.location = Forgery::Address.state
    	org.contact = Forgery::Internet.email_address
    	Event.populate 0..10 do |event|
    		event.name = Populator.words(1..3).titleize
    		event.about = Populator.sentences(1..2)
    		event.organization_id = org.id 
    		event.location = Forgery::Address.state
    		random_date = Forgery::Date.date
    		event.start = random_date
    		event.end = random_date + rand(3)
    		Team.populate 0..10 do |team|
    		  team.name = Populator.words(1..3).titleize
    		  team.event_id = event.id 
          Member.populate 1 do |member|
            # Add user as admin to each of the created items
            member.team_id = team.id
            member.admin = true
            random_user = @users.sample
            member.user_id = random_user.id
          end # /member
    		end # /team
    	end # /event
    end # /org

  end	

  def ensure_users
    @users = []
    @users << User.all.where(email: "gant@iconoclastlabs.com").first_or_create(password: "fdsafdsa")
    @users << User.all.where(email: "themoke@gmail.com").first_or_create(password: "fdsafdsa")
    @users << User.all.where(email: "daddymac@gmail.com").first_or_create(password: "fdsafdsa")
  end

  def add_admin (col, id)
    
  end
end