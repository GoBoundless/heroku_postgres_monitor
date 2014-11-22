Heroku Postgres Monitor
========================

A simple Heroku app wrapper for [newrelic_postgres_plugin](https://github.com/GoBoundless/newrelic_postgres_plugin). Send metrics from your Heroku Postgres instances to the NewRelic Platform.

![Screenshot](https://raw.github.com/GoBoundless/heroku_postgres_monitor/master/screenshot.png "Screenshot")

Usage
------------------------

#### Step 1:
Clone this repo and setup a new heroku application:
```
git clone git@github.com:GoBoundless/heroku_postgres_monitor.git
cd heroku_postgres_monitor
heroku create
```
#### Step 2:
Copy config vars from your app into the monitor app:

```
heroku config:set $(heroku config --shell --app other-app-name | egrep 'NEW_RELIC_LICENSE_KEY|postgres://')
```

Feel free to add as many Heroku Postgres instance URLs as you wish. You will need to run this command again after scaling or adding any databases.

#### Step 3:
Deploy to Heroku
```
git push heroku master
heroku ps:scale worker=1
```

Done! You should start to see data coming into your NewRelic dashboard as soon as the deploy is finished.
