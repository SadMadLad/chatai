# README

**Chatai** is a passion project where I am building any feature that I find interesting.
Currently, it has some of these features:

* A basic chat app that allows one-on-one as well as group chats. The chat uses Turbo broadcasts with redis.
* A page for Machine Learning models and get their predictions (this needs some rework).
* Admin Dashboard for most of the models to manage models.
* A Python App that uses FastAPI:
    - Has Jupyter Notebook's HTML which can be served in the Rails app.
    - Basic ML models that output result.
    - Autocompletion for Chats - GPT like (though it works, it is hacky and would need some rework).
* A frontend made in React that utilizes shadcn components.
    - The frontend uses powerful and scalable Phoenix websockets for live chat rooms and presence tracking.
    - These live chat rooms allow live communication between the users and even show which users are present in the specific live room.
* More features are on the way!!

## Specifications

*Note: Docker support will be coming soon for easier developer experience.*

### Rails

* Ruby version 3.3.0
* Tailwind
* Hotwire (StimulusJS + Turbo)
* Redis Server
* PostgreSQL Database
* Devise for authentication
* Pundit for authorization
* Solid Queue for Jobs
* Gems being used are mentioned in Gemfile.

### FastAPI

* Python 3.12.2
* Pyenv 2.3.36
* FastAPI 0.110.1
* Other Packages being used are in the `Pipfile` under the `api` folder.

### Phoenix

* Elixir 1.16.1
* Erlang 26
* Phoenix 1.17.2
* Other dependencies mentioned in `mix.exs` file under `channel/` directory.

### Frontend

* Node 18.16.0
* Vite 5.2.0
* React 18.2.0
* NPM 9.5.1

---

## Setup

### Rails Setup

1. Install the Ruby Version.
2. Install the gems using bundler: `bundle install`
3. Create the database using `rails db:create`
4. Run the migrations using the command `rails db:migrate`.
5. Seed some data `rails db:seed`
6. Run your redis server `redis-server`
7. (Not Required) For prettier, install node (18.19.0) and run `npm install` to install the packages install.
8. For action text, install the packages using `yarn`.
9. Run the `Procfile.dev` using the `bin/dev` command. This will watch for live tailwind and rails server changes. (If `bin/dev` does not work, make sure you have installed the `foreman` gem)
10. Visit `localhost:3000`. You can login as `user@0.com` with password `password` to sign in as the seeded user.

### FastAPI Setup

1. Install Python and Pip.
2. The recommended way is too use `pipenv` and `pyenv` combo, but not necessary. You can install both these packages using `pip`.
3. If you are using `pipenv`, you can install all the dependencies with `pipenv sync`. Else, you can generate the `requirements.txt` from the `Pipfile` and install the requirements using `pip` only `pip install -r requirements.txt`.
4. Run you FastAPI server (under the `api/` directory) by running the command `uvicorn main:app --reload`. The server should be live on `localhost:8000`.

### Frontend Setup

1. Install Node 18.16.0
2. Go the `frontend/` folder and install all the packages using `npm install`.

### Phoenix Setup

1. Install Elixir 1.16.1 with Erlang 26. This should install `mix` as well (which is like `bundler` for Elixir).
2. Go the the `channel/` folder and install all the dependencies using `mix deps.get` command.
3. Run the server using `mix phx.server` command.
4. The server should be live on `localhost:4000`.

---

### Some Standards

* **`TODO:`** highlights stuff that needs to be done. **`TEMP:`** is for temporary statements that should be removed or fixed later.
* Use `flake8` + `black` for Python code, `prettier` for JS and TS, `credo` for Elixir and `rubocop` for Ruby code.

