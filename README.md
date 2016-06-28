# Pxblog

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: http://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

#### Notes
  $ mix phoenix.new pxblog
  We are all set! Run your Phoenix application:
      $ cd pxblog
      $ mix ecto.create
      $ mix phoenix.server
  You can also run your app inside IEx (Interactive Elixir) as:
      $ iex -S mix phoenix.server

---- Uses Phoenix's generator to scaffold Post model and UI

$ mix phoenix.gen.html Post posts title:string body:text

Add the resource to your browser scope in web/router.ex:
    resources "/posts", PostController
Remeber to update your repository by running migrations:
    $ mix ecto.migrate

---- Controller test
conn = get conn, post_path(conn, :index)
assert html_response(conn, 200) =~ "Listing posts"
=~ : means the html_response contains the phrase "Listing posts"

---- Adding Users
$ mix phoenix.gen.html User users username:string email:string password_digest:string

Add the resource to your browser scope in web/router.ex:

    resources "/users", UserController

Remember to update your repository by running migrations:

    $ mix ecto.migrate

------ Ecto commands
  $ mix ecto.create
  $ mix ecto.drop
  $ mix ecto.migrate
  $ mix ecto.rollback

----- Saving a Password Hash instead of a Password

----- How to run test in Phoenix framework
$ mix test test/models/user_test.exs

----- Add real password hashes with Bcrypt using comeonin library
1. add :comeonin in mix.exs application block
2. add :comeonin, "~> 2.1" in deps block
3. $ mix deps.get  # get the new library

----- Adding SessionController
1. add controllers/session_controller.ex
2. add views/session_view.ex
3. add templates/session/new.html.eex

---- iex -S mix phoenix.server (Interactive Elixir Shell)
> alias Pxblog.Repo
> alias Pxblog.User

----- iex -S mix
> import Ecto.Query
> alias Pxblog.Repo
> alias Pxblog.User
> Repo.get_by(User, username: "ryan")

----- Part 2 Authorization
> elixir -v
Elixir 1.2.5
> mix phoenix.new -v
Phoenix v1.1.4

----- Adding our migration
> mix ecto.gen.migration add_user_id_to_posts
* creating priv/repo/migrations
* creating priv/repo/migrations/20160625184953_add_user_id_to_posts.exs
> mix ecto.migrate

----- Associating posts with users

-- phoenix routes
> mix phoenix.routes

-- start iex -S mix
iex -S mix
import Ecto.Query
alias Pxblog.User
alias Pxblog.Post
alias Pxblog.Repo
import Ecto.model
import Ecto

-- find user by id
>user = Repo.get(User, 4)

-- find user by attributes
>user = Repo.get_by(User, username: "ryan")

-- Ecto's build_assoc function
import Ecto
import Ecto.Query
alias Pxblog.Repo
alias Pxblog.User
alias Pxblog.Post
user = Repo.get(User, 1)
post = build_assoc(user, :posts, %{title: "Test Title", body: "Test Body"})
Repo.insert(post)
posts = Repo.all(from p in Post, preload: [:user])
post = List.first(posts)


----- Debugging Phoenix with IEx.pry
https://medium.com/@diamondgfx/debugging-phoenix-with-iex-pry-5417256e1d11#.tkgr2wprg
** using IEx.pry
---- Debugging a Controller
Add following line in web/controllers/user_controller.ex
require IEx
Add following line in index method in web/controllers/user_controller.ex
Then switch to terminal and issue following command (make sure no other session of phoenix.server is running on the same application)
>iex -S mix phoenix.server

http://blog.plataformatec.com.br/2016/04/debugging-techniques-in-elixir-lang/
http://landonmarder.com/posts/2016/01/08/iex-in-phoenix-tests/
-- First, for the file that you want to throw your IEx.pry into, add require IEx under your defmoudle line
defmodule Fishbowl.User do
  require IEx
  ...
end
-- Then, where you want to stop, enter IEx.pry
def changeset(model, params \\ :empty) do
  IEx.pry
  model
  ...

Run your test suite by running $ iex -S mix test --trace in your project directory

iex -S will open up Elixir's interactive shell so that your tests will stop when it hits an IEx.pry

--trace will prevent your Elixir interactive shell from timing out after 60 seconds.

----- Part 3 Adding Roles to models

#### Creating Roles
> mix phoenix.gen.model Role roles name:string admin:boolean
> mix ecto.migrate

##### Adding Roles Associations
-- web/models/user.ex one user has one role, and each role has many users
-- web/models/role.ex has many users
-- run mix test (expecting many failed)
-- generate migration file to add role_id to users table
> mix ecto.gen.migration add_role_id_to_users
alter table(:users) do
  add :role_id, references(:roles)
end

-- make change to models/user.ex to ensure role_id is one of the required_fields
The changed will result a lot of failures when run test again
#### Creating a Test Helper
create test/support/test_helper.ex

#### Fixing Our tests
