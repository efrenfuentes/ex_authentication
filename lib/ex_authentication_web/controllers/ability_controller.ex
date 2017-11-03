defmodule ExAuthenticationWeb.AbilityController do
  use ExAuthenticationWeb, :controller

  alias ExAuthentication.Authentication
  alias ExAuthentication.Authentication.Ability

  def index(conn, _params) do
    abilities = Authentication.list_abilities()
    render(conn, "index.html", abilities: abilities)
  end

  def new(conn, _params) do
    changeset = Authentication.change_ability(%Ability{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"ability" => ability_params}) do
    case Authentication.create_ability(ability_params) do
      {:ok, ability} ->
        conn
        |> put_flash(:info, "Ability created successfully.")
        |> redirect(to: ability_path(conn, :show, ability))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    ability = Authentication.get_ability!(id)
    render(conn, "show.html", ability: ability)
  end

  def edit(conn, %{"id" => id}) do
    ability = Authentication.get_ability!(id)
    changeset = Authentication.change_ability(ability)
    render(conn, "edit.html", ability: ability, changeset: changeset)
  end

  def update(conn, %{"id" => id, "ability" => ability_params}) do
    ability = Authentication.get_ability!(id)

    case Authentication.update_ability(ability, ability_params) do
      {:ok, ability} ->
        conn
        |> put_flash(:info, "Ability updated successfully.")
        |> redirect(to: ability_path(conn, :show, ability))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", ability: ability, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    ability = Authentication.get_ability!(id)
    {:ok, _ability} = Authentication.delete_ability(ability)

    conn
    |> put_flash(:info, "Ability deleted successfully.")
    |> redirect(to: ability_path(conn, :index))
  end
end
