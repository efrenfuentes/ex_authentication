defmodule ExAuthentication.Repo.Migrations.CreateClients do
  use Ecto.Migration

  def change do
    create table(:clients) do
      add :name, :string
      add :description, :string
      add :secret_key, :string

      timestamps()
    end

  end
end
