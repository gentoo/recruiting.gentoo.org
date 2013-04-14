How to deploy this application
--------------

* install ruby 1.9.3
* install and setup postgresql
* install bundler by

```
gem i bundler --no-rdoc --no-ri
```

* install dependencies

```
bundle
```

* prepare database

first modify config/database.yml.example
then

```
mv config/database.yml.example config/database.yml
RAILS_ENV=productoin bundle exec rake db:create
RAILS_ENV=productoin bundle exec rake db:data:load
```

* start webserver

```
bundle exec thin -p 8080 -e production -d
```
