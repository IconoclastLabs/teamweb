Team Web
=======

[![Travis-CI](https://api.travis-ci.org/GantMan/teamweb.png)](https://travis-ci.org/GantMan/teamweb)

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
* Large commit on the project, which can be explained in the commit page link [COMMIT](https://github.com/GantMan/teamweb/commit/6ba46f798f6fac3cc21830ebbe36d3340a6a42ad)

`--> COMMIT PROJECT`

* Lots of changes adding teams as resources under events
* Changes made by daddymac - [COMMIT]https://github.com/GantMan/teamweb/commit/2b60e8d134bca92dc626ae89e348a6be51fd4b50)
* Changes made by GantMan - [COMMIT](https://github.com/GantMan/teamweb/commit/628936b7c6648b4f31a9b7fb8ad5522d4d19232c)

`--> Project Point`

$ rails generate simple_form:install --bootstrap
* Converted some forms and styles to twitter bootstrap and simple_form

`--> Project Point`

* Moved tables/breadcrumbs/buttons over to Twitter bootstrap style.
* Updated breadcrumbs to add/style themselves via navigation helper [COMMIT](https://github.com/GantMan/teamweb/commit/71fd221dc4343b33e9e98d3d4243f51a713fec5a)
* Updated navbar to style itself via navigation helper [COMMIT](https://github.com/GantMan/teamweb/commit/2e2cdcd515c6b0ae852607c48bfec6c4390b9ffd)

`--> Project Point`

* Added devise gem
$ rails generate devise:install
$ rails generate devise user
* Added devise links to navigation header
* Added devise `authenticate_user!` to all controllers
$ rails generate devise:views
* Views styled by @daddymac

`--> Project Point`

* Server switched over to `puma` multithreaded [COMMIT](https://github.com/GantMan/teamweb/commit/5655e39b0885f24916ac039c0ddca75eab54cc89) [GIST](https://gist.github.com/subelsky/3987140)

`--> COMMIT PROJECT`

### SWITCH TO RAILS 4 ###
* installed rails4 (gem install rails)
* Gemfile - updated rails version and removed assets group
* changed application config to simply use bundler
* did environment updates
$ gem update
$ rm Gemfile.lock
$ bundle update
$ bundle outdated
* Added version tags to various gems to use rails 4
* Removed attr_accessibles and moved to strong params approach
* Renamed secret token
* Removed vendor/plugins directory (no longer allowed)

`--> Merged Branch`

* Fixed all tests to pass!
* ADDED Travis-CI for continual integration testing - Format [travis.yml](https://github.com/GantMan/teamweb/blob/master/.travis.yml)

`--> Project Point`

* Added a nice rake task to populate table with junk data via `rake db:populate`

`--> Project Point`
