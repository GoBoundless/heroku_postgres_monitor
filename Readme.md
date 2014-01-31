Heroku Postgres Monitor
========================

A simple Heroku app to run the newrelic_postgres_plugin to send metrics from a Postgres DB to the NewRelic Platform.

Usage
------------------------

#### Step 1:
Clone this repo and setup a new heroku application:
```
git clone git@github.com:GoBoundless/heroku_postgres_monitor.git
cd heroku_postgres_monitor
heroku create <new app name>
```
#### Step 2:
Setup the Heroku config variables needed to run the plugin:
```
heroku config:set DATABASE_URL="username:password@host:port/database_name"
heroku config:set NEW_RELIC_LICENSE_KEY="your license key"
```

Alternatively, if you're monitoring a different heroku app, you can use this command to copy the config over:
```
heroku config:set $(heroku config --shell --app other-app-name | egrep '^(DATABASE_URL|HEROKU_POSTGRES|NEW_RELIC_LICENSE_KEY)=' )
```

#### Step 3:
Deploy to Heroku
```
git push heroku master
```

Done! You should start to see data coming into your NewRelic dashboard as soon as the deploy is finished.

Notes
------------------------
For the time being we are using a fork of the newrelic_plugin gem that enables ERB parsing of the config file. We've submitted a pull request and will go back to relying on the standard gem distribution if/when it is accepted.