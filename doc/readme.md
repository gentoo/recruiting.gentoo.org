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
bundle install --deployment --without development
```

* prepare database

first modify config/database.yml.example
then

```
cp config/database.yml.example config/database.yml
cp config/initializers/secret_token.rb.example config/initializers/secret_token.rb
RAILS_ENV=productoin bundle exec rake db:create
RAILS_ENV=productoin bundle exec rake db:schema:load
RAILS_ENV=productoin bundle exec rake db:data:load
```

* compile assets
```
RAILS_ENV=production bundle exec rake assets:precompile
```

* start webserver

```
bundle exec thin -p 8080 -e production -d
```
