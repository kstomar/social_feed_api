# README

## Required Environment / Minimum Setup

Ruby version is `2.6.5`.
Rails version is `6.1.6`.

Minimum setup required to run the app:

```shell
git clone https://github.com/kstomar/social_feed_api.git
cd social_feed_api
bundle install

# NOTE: ENV values to be added in credentials.enc
#  feed_base_url: https://takehome.io

EDITOR=vim rails credentials:edit

# SetUp database
rails db:create db:migrate

# Start the rails server using
rails server
```

## Testing

Run the test suite to confirm if the setup is successful.

Make sure that the test database is prepared:

```shell
RAILS_ENV=test rails db:structure:load
```

Then run test suites:

```shell
rspec
```
