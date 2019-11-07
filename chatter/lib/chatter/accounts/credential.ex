defmodule Chatter.Accounts.Credential do
  use Ecto.Schema
  import Ecto.Changeset
  alias Comeonin.Argon2

  schema "credentials" do
    field :email, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    belongs_to :user, Chatter.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(credential, attrs) do
    credential
    |> cast(attrs, [:email, :password_hash])
    |> validate_required([:email, :password_hash])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
  end

  def registration_changeset(struct, attrs = %{}) do
    struct
    |> changeset(attrs)
    |> cast(attrs, [:password, :password_confirmation])
    |> validate_required(attrs, [:password, :password_confirmation])
    |> validate_length(:password, min: 8)
    # password_cofirmation is assumed
    |> validate_confirmation(:password)
    |> hash_password()
  end

  defp hash_password(%{valid?: false} = changeset), do: changeset

  defp hash_password(%{valid?: true, changes: %{password: [pwd]}} = changeset) do
    put_change(changeset, :password_hash, Argon2.hashpwsalt(pass))
  end
end
