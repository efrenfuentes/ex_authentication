defmodule ExAuthenticationWeb.AbilityControllerTest do
  use ExAuthenticationWeb.ConnCase

  alias ExAuthentication.Authentication

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:ability) do
    {:ok, ability} = Authentication.create_ability(@create_attrs)
    ability
  end

  describe "index" do
    test "lists all abilities", %{conn: conn} do
      conn = get conn, ability_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Abilities"
    end
  end

  describe "new ability" do
    test "renders form", %{conn: conn} do
      conn = get conn, ability_path(conn, :new)
      assert html_response(conn, 200) =~ "New Ability"
    end
  end

  describe "create ability" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, ability_path(conn, :create), ability: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ability_path(conn, :show, id)

      conn = get conn, ability_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Ability"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, ability_path(conn, :create), ability: @invalid_attrs
      assert html_response(conn, 200) =~ "New Ability"
    end
  end

  describe "edit ability" do
    setup [:create_ability]

    test "renders form for editing chosen ability", %{conn: conn, ability: ability} do
      conn = get conn, ability_path(conn, :edit, ability)
      assert html_response(conn, 200) =~ "Edit Ability"
    end
  end

  describe "update ability" do
    setup [:create_ability]

    test "redirects when data is valid", %{conn: conn, ability: ability} do
      conn = put conn, ability_path(conn, :update, ability), ability: @update_attrs
      assert redirected_to(conn) == ability_path(conn, :show, ability)

      conn = get conn, ability_path(conn, :show, ability)
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, ability: ability} do
      conn = put conn, ability_path(conn, :update, ability), ability: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Ability"
    end
  end

  describe "delete ability" do
    setup [:create_ability]

    test "deletes chosen ability", %{conn: conn, ability: ability} do
      conn = delete conn, ability_path(conn, :delete, ability)
      assert redirected_to(conn) == ability_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, ability_path(conn, :show, ability)
      end
    end
  end

  defp create_ability(_) do
    ability = fixture(:ability)
    {:ok, ability: ability}
  end
end
