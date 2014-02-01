Heroku Postgres Monitor
========================

A simple Heroku app to run the newrelic_postgres_plugin to send metrics from a Postgres DB to the NewRelic Platform.

![Screenshot](https://raw.github.com/GoBoundless/heroku_postgres_monitor/master/screenshot.png "Screenshot")

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
heroku config:set $(heroku config --shell --app other-app-name | egrep '^(postgres://|NEW_RELIC_LICENSE_KEY)' )
```

Feel free to add as many Heroku Postgres instance URLs as you wish.

#### Step 3:
Deploy to Heroku
```
git push heroku master
```

Done! You should start to see data coming into your NewRelic dashboard as soon as the deploy is finished.
