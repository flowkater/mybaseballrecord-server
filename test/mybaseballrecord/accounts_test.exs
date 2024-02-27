defmodule Mybaseballrecord.AccountsTest do
  use Mybaseballrecord.DataCase

  alias Mybaseballrecord.Accounts

  describe "users" do
    alias Mybaseballrecord.Accounts.User

    import Mybaseballrecord.AccountsFixtures

    @invalid_attrs %{name: nil, role: nil, email: nil, birthday: nil, intro: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{
        name: "some name",
        role: "some role",
        email: "some email",
        birthday: ~D[2024-02-26],
        intro: "some intro"
      }

      assert {:ok, %User{} = user} = Accounts.create_user(valid_attrs)
      assert user.name == "some name"
      assert user.role == "some role"
      assert user.email == "some email"
      assert user.birthday == ~D[2024-02-26]
      assert user.intro == "some intro"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()

      update_attrs = %{
        name: "some updated name",
        role: "some updated role",
        email: "some updated email",
        birthday: ~D[2024-02-27],
        intro: "some updated intro"
      }

      assert {:ok, %User{} = user} = Accounts.update_user(user, update_attrs)
      assert user.name == "some updated name"
      assert user.role == "some updated role"
      assert user.email == "some updated email"
      assert user.birthday == ~D[2024-02-27]
      assert user.intro == "some updated intro"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
