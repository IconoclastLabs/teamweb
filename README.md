Team Web
=======
[![Travis-CI Build Status](https://api.travis-ci.org/GantMan/teamweb.png)](https://travis-ci.org/GantMan/teamweb)

## 1: Qu'est-ce que c'est?
####Simple yet fully tested Rails 4 app for managing signups for events.  
A somewhat up to date example can (usually) be found here: [http://teamweb.heroku.com/](http://teamweb.heroku.com/)

## 2: Getting Started
*Tech Stack:* Ruby 2, Rails 4, SASS, HAML, Twitter Bootstrap

This project has served as a teaching project in TDD with Rails.  
Ruby 2.0, Rails 4, Bundler, and SQLite >= 3.7.13 should already be installed and functional before running the following.

```
$ git clone git@github.com:GantMan/teamweb.git
$ cd teamweb
$ bundle install
$ rake db:setup
```
There is an optional db:populate rake task that creates test data and users ([via Populator](https://github.com/ryanb/populator)).
Add your user to `lib/tasks/populate.rake` to customize, then run the following:
```
$ rake db:populate
```

## 3: Hows it going?
* Human History in the [CHANGELOG.md](https://github.com/GantMan/teamweb/blob/master/CHANGELOG.md) 
* Testing History via [Travis-CI](https://travis-ci.org/GantMan/teamweb/builds)
* Sometimes updated live site: [http://teamweb.heroku.com/](http://teamweb.heroku.com/)