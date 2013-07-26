namespace :db do
	desc "Populate database with nice sample data"
	task :populate => :environment do
    require 'populator'
    require 'forgery'

    # Create some users for login and admins (if they don't already exist)
    admins = ensure_admins

    # Randomly make other users
    add_users 

    # Everyone who is not in the admin array
    non_admins = User.where.not(id: admins.map(&:id))

    # Create some Organizations with Events with Teams with Members
    add_full_org_stack(admins, non_admins)

    # Force Organizations friendly_ids to get generated on new records
    Organization.find_each(&:save)
    # Force event maps to save, thus grab actual lat/long from google
    Event.find_each(&:save)

  end	

  def ensure_admins
    admins = []
    admins << User.where(email: "gant@iconoclastlabs.com").first_or_create(password: "fdsafdsa", name: "Gant Man", phone: "888-888-8888", address: "New Orleans")
    admins << User.where(email: "themoke@gmail.com").first_or_create(password: "fdsafdsa", name: "Mokus", phone: "888-888-8888", address: "New Orleans")
    admins << User.where(email: "daddymac@gmail.com").first_or_create(password: "fdsafdsa", name: "Cbrou", phone: "888-888-8888", address: "New Orleans")
    admins
  end

  def add_users(quantity = 5)
    User.populate quantity do |user|
      user.email = Forgery::Internet.email_address
      user.encrypted_password = Forgery::Basic.encrypt
      user.name = Forgery::Name.full_name
      user.phone = Forgery::Address.phone
      user.address = Forgery::Address.state
    end
  end

  def add_full_org_stack(admins, non_admins)
    Organization.populate(5) do |org|
      org.name = Forgery::Name.full_name
      org.about = Populator.sentences(1)
      org.location = Forgery::Address.state
      org.contact = Forgery::Internet.email_address
      add_admin(admins, "organization_id", org)
      add_members(non_admins, "organization_id", org)
      Event.populate 0..5 do |event|
        event.name = Populator.words(1..3).titleize
        event.about = Populator.sentences(1..2)
        event.organization_id = org.id 
        event.location = Forgery::Address.state
        random_date = Forgery::Date.date
        event.start = random_date
        event.end = random_date + rand(3)
        add_admin(admins, "event_id", event)
        add_members(non_admins, "event_id", event)
        Team.populate 0..5 do |team|
          team.name = Populator.words(1..3).titleize
          team.event_id = event.id 
          add_admin(admins, "team_id", team)
          add_members(non_admins, "team_id", team)
        end # /team
      end # /event
    end # /org
  end

  def add_admin (user_set, col, item, quantity = 1)
    raise "Can't add more admins than user_set exists" if quantity > user_set.size
    Member.populate quantity do |member|
      # Using eval because populator record doesn't support array lookup of attributes
      eval("member.#{col} = item.id")
      member.admin = true
      random_user = user_set.sample
      member.user_id = random_user.id
    end # /member   
  end

  def add_members(user_set, col, item, quantity = 2)
    raise "Can't add more members than user_set exists" if quantity > user_set.size
    # size the user_set down to a random subset of size quantity
    user_set = user_set.sample(quantity)
    # Create those members!
    Member.populate quantity do |member|
      # Using eval because populator record doesn't support array lookup of attributes
      eval("member.#{col} = item.id")
      random_user = user_set.pop
      member.user_id = random_user.id
    end # /member  
  end 
end