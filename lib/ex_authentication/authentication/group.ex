defmodule ExAuthentication.Authentication.Group do
  use Ecto.Schema
  import Ecto.Changeset
  alias ExAuthentication.Authentication.Group


  schema "groups" do
    field :description, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Group{} = group, attrs) do
    group
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
