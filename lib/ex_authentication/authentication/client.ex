defmodule ExAuthentication.Authentication.Client do
  use Ecto.Schema
  import Ecto.Changeset
  alias ExAuthentication.Authentication.Client


  schema "clients" do
    field :description, :string
    field :name, :string
    field :secret_key, :string

    timestamps()
  end

  @doc false
  def changeset(%Client{} = client, attrs) do
    client
    |> cast(attrs, [:name, :description, :secret_key])
    |> validate_required([:name, :description, :secret_key])
  end
end
