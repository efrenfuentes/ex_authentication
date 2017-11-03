defmodule ExAuthentication.AuthenticationTest do
  use ExAuthentication.DataCase

  alias ExAuthentication.Authentication

  describe "groups" do
    alias ExAuthentication.Authentication.Group

    @valid_attrs %{description: "some description", name: "some name"}
    @update_attrs %{description: "some updated description", name: "some updated name"}
    @invalid_attrs %{description: nil, name: nil}

    def group_fixture(attrs \\ %{}) do
      {:ok, group} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Authentication.create_group()

      group
    end

    test "list_groups/0 returns all groups" do
      group = group_fixture()
      assert Authentication.list_groups() == [group]
    end

    test "get_group!/1 returns the group with given id" do
      group = group_fixture()
      assert Authentication.get_group!(group.id) == group
    end

    test "create_group/1 with valid data creates a group" do
      assert {:ok, %Group{} = group} = Authentication.create_group(@valid_attrs)
      assert group.description == "some description"
      assert group.name == "some name"
    end

    test "create_group/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Authentication.create_group(@invalid_attrs)
    end

    test "update_group/2 with valid data updates the group" do
      group = group_fixture()
      assert {:ok, group} = Authentication.update_group(group, @update_attrs)
      assert %Group{} = group
      assert group.description == "some updated description"
      assert group.name == "some updated name"
    end

    test "update_group/2 with invalid data returns error changeset" do
      group = group_fixture()
      assert {:error, %Ecto.Changeset{}} = Authentication.update_group(group, @invalid_attrs)
      assert group == Authentication.get_group!(group.id)
    end

    test "delete_group/1 deletes the group" do
      group = group_fixture()
      assert {:ok, %Group{}} = Authentication.delete_group(group)
      assert_raise Ecto.NoResultsError, fn -> Authentication.get_group!(group.id) end
    end

    test "change_group/1 returns a group changeset" do
      group = group_fixture()
      assert %Ecto.Changeset{} = Authentication.change_group(group)
    end
  end

  describe "users" do
    alias ExAuthentication.Authentication.User

    @valid_attrs %{email: "some email", encrypted_password: "some encrypted_password", name: "some name"}
    @update_attrs %{email: "some updated email", encrypted_password: "some updated encrypted_password", name: "some updated name"}
    @invalid_attrs %{email: nil, encrypted_password: nil, name: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Authentication.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Authentication.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Authentication.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Authentication.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.encrypted_password == "some encrypted_password"
      assert user.name == "some name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Authentication.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Authentication.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.email == "some updated email"
      assert user.encrypted_password == "some updated encrypted_password"
      assert user.name == "some updated name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Authentication.update_user(user, @invalid_attrs)
      assert user == Authentication.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Authentication.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Authentication.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Authentication.change_user(user)
    end
  end

  describe "clients" do
    alias ExAuthentication.Authentication.Client

    @valid_attrs %{description: "some description", name: "some name", secret_key: "some secret_key"}
    @update_attrs %{description: "some updated description", name: "some updated name", secret_key: "some updated secret_key"}
    @invalid_attrs %{description: nil, name: nil, secret_key: nil}

    def client_fixture(attrs \\ %{}) do
      {:ok, client} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Authentication.create_client()

      client
    end

    test "list_clients/0 returns all clients" do
      client = client_fixture()
      assert Authentication.list_clients() == [client]
    end

    test "get_client!/1 returns the client with given id" do
      client = client_fixture()
      assert Authentication.get_client!(client.id) == client
    end

    test "create_client/1 with valid data creates a client" do
      assert {:ok, %Client{} = client} = Authentication.create_client(@valid_attrs)
      assert client.description == "some description"
      assert client.name == "some name"
      assert client.secret_key == "some secret_key"
    end

    test "create_client/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Authentication.create_client(@invalid_attrs)
    end

    test "update_client/2 with valid data updates the client" do
      client = client_fixture()
      assert {:ok, client} = Authentication.update_client(client, @update_attrs)
      assert %Client{} = client
      assert client.description == "some updated description"
      assert client.name == "some updated name"
      assert client.secret_key == "some updated secret_key"
    end

    test "update_client/2 with invalid data returns error changeset" do
      client = client_fixture()
      assert {:error, %Ecto.Changeset{}} = Authentication.update_client(client, @invalid_attrs)
      assert client == Authentication.get_client!(client.id)
    end

    test "delete_client/1 deletes the client" do
      client = client_fixture()
      assert {:ok, %Client{}} = Authentication.delete_client(client)
      assert_raise Ecto.NoResultsError, fn -> Authentication.get_client!(client.id) end
    end

    test "change_client/1 returns a client changeset" do
      client = client_fixture()
      assert %Ecto.Changeset{} = Authentication.change_client(client)
    end
  end

  describe "abilities" do
    alias ExAuthentication.Authentication.Ability

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def ability_fixture(attrs \\ %{}) do
      {:ok, ability} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Authentication.create_ability()

      ability
    end

    test "list_abilities/0 returns all abilities" do
      ability = ability_fixture()
      assert Authentication.list_abilities() == [ability]
    end

    test "get_ability!/1 returns the ability with given id" do
      ability = ability_fixture()
      assert Authentication.get_ability!(ability.id) == ability
    end

    test "create_ability/1 with valid data creates a ability" do
      assert {:ok, %Ability{} = ability} = Authentication.create_ability(@valid_attrs)
      assert ability.name == "some name"
    end

    test "create_ability/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Authentication.create_ability(@invalid_attrs)
    end

    test "update_ability/2 with valid data updates the ability" do
      ability = ability_fixture()
      assert {:ok, ability} = Authentication.update_ability(ability, @update_attrs)
      assert %Ability{} = ability
      assert ability.name == "some updated name"
    end

    test "update_ability/2 with invalid data returns error changeset" do
      ability = ability_fixture()
      assert {:error, %Ecto.Changeset{}} = Authentication.update_ability(ability, @invalid_attrs)
      assert ability == Authentication.get_ability!(ability.id)
    end

    test "delete_ability/1 deletes the ability" do
      ability = ability_fixture()
      assert {:ok, %Ability{}} = Authentication.delete_ability(ability)
      assert_raise Ecto.NoResultsError, fn -> Authentication.get_ability!(ability.id) end
    end

    test "change_ability/1 returns a ability changeset" do
      ability = ability_fixture()
      assert %Ecto.Changeset{} = Authentication.change_ability(ability)
    end
  end
end
