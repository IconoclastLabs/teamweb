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
      add_admin("organization_id", org)
    	Event.populate 0..10 do |event|
    		event.name = Populator.words(1..3).titleize
    		event.about = Populator.sentences(1..2)
    		event.organization_id = org.id 
    		event.location = Forgery::Address.state
    		random_date = Forgery::Date.date
    		event.start = random_date
    		event.end = random_date + rand(3)
        add_admin("event_id", event)
    		Team.populate 0..10 do |team|
    		  team.name = Populator.words(1..3).titleize
    		  team.event_id = event.id 
          add_admin("team_id", team)
    		end # /team
    	end # /event
    end # /org

    # Force Organizations friendly_ids to get generated from the above records
    Organization.find_each(&:save)
    # Force event maps to save, thus grab actual lat/long from google
    Event.find_each(&:save)

  end	

  def ensure_users
    @users = []
    @users << User.all.where(email: "gant@iconoclastlabs.com").first_or_create(password: "fdsafdsa", name: "Gant Man", phone: "888-888-8888", address: "New Orleans")
    @users << User.all.where(email: "themoke@gmail.com").first_or_create(password: "fdsafdsa", name: "Mokus", phone: "888-888-8888", address: "New Orleans")
    @users << User.all.where(email: "daddymac@gmail.com").first_or_create(password: "fdsafdsa", name: "Cbrou", phone: "888-888-8888", address: "New Orleans")
  end

  def add_admin (col, item, quantity = 1)
    raise "Can't add more admins than users exist" if quantity > @users.size
    Member.populate quantity do |member|
      # Using eval because populator record doesn't support array lookup of attributes
      eval("member.#{col} = item.id")
      member.admin = true
      random_user = @users.sample
      member.user_id = random_user.id
    end # /member   
  end
end