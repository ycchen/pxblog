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
[debug] SELECT u0."id", u0."username", u0."email", u0."password_digest", u0."inserted_at", u0."updated_at" FROM "users" AS u0 WHERE (u0."username" = $1) ["ryan"] OK query=118.1ms queue=20.7ms
