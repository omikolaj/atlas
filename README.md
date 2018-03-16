## Description

Atlas is a full MVC Sinatra web application that provides users with information about countries around the world. Atlas integrates a RESTful api that populates each country's details. Atlas implements a custom login and signup flow. When user is logged in they are able to select a country/countries they like and add it to their favorites. In 'Dashboard' users can view the countries they have saved as well as edit their profile information. Atlas uses PostgreSQL database

This project has been built using:
- Ruby
- ActiveRecord
- PostgreSQL
- Bootstrap
- RESTful api https://restcountries.eu/

## Blog

I wrote a blog about this project you can find it www.omiko.co/blog/sinatra-project-and-deployment-to-heroku

## Usage

Atlas has been deployed to Heroku. It can be found at http://atlas-globe.herokuapp.com. You do not have to signup for an account, you can just use the 'Login as gues' option.

After cloning the repo run 'bundle install' and 'rake db:migrate'. 

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/omikolaj/atlas. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

