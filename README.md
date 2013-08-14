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

#### Tests
Integration testing is done using PhantomJS using the Poltergeist driver
for Capybara.  Installing PhantomJS is a manual step you must perform.

#### OSX: 

    brew update && brew install phantomjs

#### Linux (manually):

    cd /usr/local/share
    wget
    http://phantomjs.googlecode.com/files/phantomjs-1.9.1-linux-x86_64.tar.bz2
    tar xjf phantomjs-1.9.1-linux-x86_64.tar.bz2
    sudo ln -s /usr/local/share/phantomjs-1.9.1-linux-x86_64/bin/phantomjs /usr/local/share/phantomjs
    sudo ln -s /usr/local/share/phantomjs-1.9.1-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs
    sudo ln -s /usr/local/share/phantomjs-1.9.1-linux-x86_64/bin/phantomjs /usr/bin/phantomjs

#### Ubuntu >12.10:

Still install it manually. `sudo apt-get install phantomjs` as of 13.04 will still install 1.6.x which is quite old.

#### Windows:

Why do you hate yourself?

## 3: Hows it going?

* Human readable History in the [WIKI](https://github.com/GantMan/teamweb/wiki/History) or a more detailed version [in our commits](https://github.com/GantMan/teamweb/commits/master)
* Testing History via [Travis-CI](https://travis-ci.org/GantMan/teamweb/builds)
* Got ideas?  Add them to the [issues!](https://github.com/GantMan/teamweb/issues?state=open) 
* Sometimes updated live site: [http://teamweb.heroku.com/](http://teamweb.heroku.com/)
