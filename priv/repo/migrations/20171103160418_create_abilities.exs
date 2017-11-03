defmodule ExAuthentication.Repo.Migrations.CreateAbilities do
  use Ecto.Migration

  def change do
    create table(:abilities) do
      add :name, :string
      add :client_id, references(:clients, on_delete: :nothing)

      timestamps()
    end

    create index(:abilities, [:client_id])
  end
end
