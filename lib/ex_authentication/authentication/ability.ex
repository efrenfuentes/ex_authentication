defmodule ExAuthentication.Authentication.Ability do
  use Ecto.Schema
  import Ecto.Changeset
  alias ExAuthentication.Authentication.Ability


  schema "abilities" do
    field :name, :string
    field :client_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Ability{} = ability, attrs) do
    ability
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
