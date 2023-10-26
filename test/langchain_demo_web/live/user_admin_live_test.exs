defmodule LangChainDemoWeb.UserAdminLiveTest do
  use LangChainDemoWeb.ConnCase

  import Phoenix.LiveViewTest
  import LangChainDemo.FitnessUsersFixtures

  defp create_user(_) do
    user = fitness_user_fixture()
    %{user: user}
  end

  describe "Index" do
    setup [:create_user]

    test "lists all user", %{conn: conn, user: user} do
      {:ok, _index_live, html} = live(conn, ~p"/admin/users")

      assert html =~ "All Users"
      assert html =~ user.name
    end

    test "saves new user", %{conn: conn} do
      {:ok, index_live, html} = live(conn, ~p"/admin/users")

      assert index_live |> element("a", "New User admin") |> render_click() =~
               "New User admin"

      assert_patch(index_live, ~p"/admin/users/new")

      invalid_attrs = valid_fitness_user_attrs(name: nil)

      assert index_live
             |> form("#user-form", user: invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      create_attrs = valid_fitness_user_attrs()

      # {TO} User's name is not present on the page (because user has not been
      # created)
      refute html =~ create_attrs.name

      assert index_live
             |> form("#user-form", user: create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/admin/users")

      html = render(index_live)
      assert html =~ "User admin created successfully"

      # {TO} User name is present on the page because user is created
      assert html =~ create_attrs.name
    end

    test "updates user in listing", %{conn: conn, user: user} do
      {:ok, index_live, _html} = live(conn, ~p"/admin/users")

      assert index_live |> element("#users-#{user.id} a", "Edit") |> render_click() =~
               "Edit User admin"

      assert_patch(index_live, ~p"/admin/users/#{user}/edit")

      invalid_attrs = valid_fitness_user_attrs(name: nil)

      assert index_live
             |> form("#user-form", user: invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      update_attrs = valid_fitness_user_attrs()

      assert index_live
             |> form("#user-form", user: update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/admin/users")

      html = render(index_live)
      assert html =~ "User admin updated successfully"

      assert html =~ update_attrs.name
      refute html =~ user.name
    end

    test "deletes user in listing", %{conn: conn, user: user} do
      {:ok, index_live, _html} = live(conn, ~p"/admin/users")

      assert index_live |> element("#users-#{user.id} a", "Delete") |> render_click()

      refute has_element?(index_live, "#users-#{user.id}")
    end
  end

  describe "Show" do
    setup [:create_user]

    test "displays user", %{conn: conn, user: user} do
      {:ok, _show_live, html} = live(conn, ~p"/admin/users/#{user}")

      assert html =~ "Show User admin"
      assert html =~ user.name
    end

    test "updates user within modal", %{conn: conn, user: user} do
      {:ok, show_live, _html} = live(conn, ~p"/admin/users/#{user}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit User admin"

      assert_patch(show_live, ~p"/admin/users/#{user}/show/edit")

      invalid_attrs = valid_fitness_user_attrs(name: nil)

      assert show_live
             |> form("#user-form", user: invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      update_attrs = valid_fitness_user_attrs()

      assert show_live
             |> form("#user-form", user: update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/admin/users/#{user}")

      html = render(show_live)
      assert html =~ "User admin updated successfully"
      assert html =~ update_attrs.name
      refute html =~ user.name
    end
  end
end
