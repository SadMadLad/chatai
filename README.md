# README

## Specifications

* Ruby version 3.3.0
* Tailwind
* Hotwire (StimulusJS + Turbo)
* Redis Server
* PostgreSQL Database
* Devise for authentication
* Pundit for authorization

## Setup


### Rails setup

1. Install the Ruby Version.
2. Install the gems using bundler: `bundle install`
3. Create the database using `rails db:create`
4. Run the migrations using the command `rails db:migrate`.
5. Seed some data `rails db:seed`
6. Run your redis server `redis-server`
7. (Not Required) For prettier, install node (18.19.0) and run `npm install` to install the packages install.
8. For action text, install the packages using `yarn`.
9. Run the `Procfile.dev` using the `bin/dev` command. This will watch for live tailwind and rails server changes.
10. Visit `localhost:3000`. You can login as `user@0.com` with password `password` to sign in as the seeded user.

### FastAPI setup

---

