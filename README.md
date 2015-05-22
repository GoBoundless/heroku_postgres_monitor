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

Bonus
------------------------

#### Keeping your DATABASE_URL up-to-date with Heroku attach
Heroku automatically manages your DATABASE_URL in your main application for you. If your database server fails or for some reason Heroku moves your database to a new host, they will update your DATABASE_URL in your main application.
We can have Heroku update our DATABASE_URL in our Heroku Postgres Monitor app as well by using `addons:attach`.

First, install the addon-attachments plugin. This allows you to attach a single Heroku addon to multiple applications.
```
heroku plugins:install https://github.com/heroku/heroku-addon-attachments.git
```

Next, list your existing attachments for the primary application you are monitoring.
```
heroku addons --app your_main_application_name
=== Resources for your_main_application_name
Plan                         Name                      Price
---------------------------  ------------------------  --------------
heroku-postgresql:premium-4  funny-name-1234       $xx.xx/month


=== Attachments for your_main_application_name
Name                        Add-on                    Billing App
--------------------------  ------------------------  -----------
DATABASE                    funny-name-1234            your_main_application_name
```

Now, you'll use your add-on name from the previous command to attach it to your Heroku Postgres Monitor app.

```
heroku addons:attach funny-name-1234 --as DATABASE
```

That's it, now if for some reason your DATABASE_URL has to change in your main application. Your monitoring will be updated as well.
