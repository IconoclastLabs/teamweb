Team Web
=======


## Teaching Project
Site for building teams for events and signup.  
Phase 1: Functional Base
* RoR Site with Twitter Bootstrap and HTML5 Boilerplate
* Cucumber and Loose specs
* User accounts via Devise
* Admin via RailsAdmin
* Functional Site

Phase 2: Stripe Integration

Phase 3: Profit

## Project History Path
  
  $ rails new teamweb
  
* DELETED STATIC HOME PAGE
* MODIFIED GEM FILE (added things we'll need)

  $ bundle install
  
* ADDED BOOTSTRAP FILES FOR RESPONSIVE DESIGN

  $ rails generate controller home index #Main Page Controller
  
* MODIFIED config/routes 

`--> COMMIT PROJECT`


* MODIFIED GEM FILE (added Cucumber)
  
  $ bundle install

  $ rails generate cucumber:install --testunit --capybara
  
`--> COMMIT PROJECT`


$ rails g boilerplate:install #For HTML5 Base awesomeness

`--> COMMIT PROJECT`

$ rails g scaffold Coordinator name:string about:string location:string contact:string 

$ rails g scaffold Event name:string about:string coordinator:references location:string start:date end:date

$ rails g scaffold Team name:string event:references 

$ rake db:migrate 

* Modified Models to have has_many relationships (belongs_to was already
  done by references) 

`--> COMMIT PROJECT`

* Added gem 'compass-rails'

$ bundle update

$ compass install bootstrap

* IMPLEMENTED TWITTER BOOTSTRAP TEMPLATE with Partials

`--> COMMIT PROJECT`

* Converted erb to haml with html2haml gem

`--> COMMIT PROJECT`

* Moved events resources under coordinators and made all cascading changes needed.
* Large commit on the project, which can be explained in the commit page link [https://github.com/GantMan/teamweb/commit/6ba46f798f6fac3cc21830ebbe36d3340a6a42ad](https://github.com/GantMan/teamweb/commit/6ba46f798f6fac3cc21830ebbe36d3340a6a42ad)

`--> COMMIT PROJECT`
