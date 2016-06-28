defmodule Pxblog.User do
  import Comeonin.Bcrypt, only: [hashpwsalt: 1]
  use Pxblog.Web, :model
  schema "users" do
    field :username, :string
    field :email, :string
    field :password_digest, :string

    has_many :posts, Pxblog.Post
    belongs_to :role, Pxblog.Role
    timestamps

    # Virtual Fields
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
  end

  @required_fields ~w(username email password password_confirmation role_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> hash_password
  end

  def hash_password(changeset) do
    if password = get_change(changeset, :password) do
      changeset
      |> put_change(:password_digest, hashpwsalt(password))
    else
      changeset
    end
  end
end
