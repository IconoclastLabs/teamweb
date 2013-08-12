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
      add_members(admins, "Organization", org, true)
      add_members(non_admins, "Organization", org, false, 2)
      Event.populate 0..5 do |event|
        event.name = Populator.words(1..3).titleize
        event.about = Populator.sentences(1..2)
        event.organization_id = org.id 
        event.location = Forgery::Address.state
        event.start = Forgery::Date.date
        event.end = event.start + rand(3)
        add_members(admins, "Event", event, true)
        
        #sometimes add non-admin members
        event.members_allowed = Forgery::Basic.boolean
        if event.members_allowed
          add_members(non_admins, "Event", event, false, 2)
        end

        #sometimes add teams
        event.teams_allowed = Forgery::Basic.boolean
        if event.teams_allowed
          event.max_teams = rand(6..12)
          Team.populate 0..5 do |team|
            team.name = Populator.words(1..3).titleize
            team.event_id = event.id 
            team.max_members = sometimes(rand(3..20))
            add_members(admins, "Team", team, true)
            add_members(non_admins, "Team", team, false, 2)
          end # /team
        end

      end # /event
    end # /org
  end

  # return a value half the time
  def sometimes (value)
    value if Forgery::Basic.boolean
  end

  # Kinda dirty way to add members, could use a refactor to happen after full_org_stack
  def add_members(user_set, col, item, admin, quantity = 1)
    raise "Can't add more members than user_set exists" if quantity > user_set.size
    # size the user_set down to a random subset of size quantity
    user_set = user_set.sample(quantity)
    # Create those members!
    Member.populate quantity do |member|
      # Using eval because populator record doesn't support array lookup of attributes
      member.groupable_type = col 
      member.groupable_id = item.id
      member.admin = admin
      random_user = user_set.pop
      member.user_id = random_user.id
    end # /member  
  end 
end