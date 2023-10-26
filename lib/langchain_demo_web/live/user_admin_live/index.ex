defmodule LangChainDemoWeb.UserAdminLive.Index do
  use LangChainDemoWeb, :live_view

  alias LangChainDemo.FitnessUsers
  alias LangChainDemo.FitnessUsers.FitnessUser

  @impl true
  def mount(_params, _session, socket) do
    {
      :ok,
      stream(
        socket,
        :users,
        FitnessUsers.list_fitness_users()
      )
    }
  end

  @impl true
  def handle_params(params, _url, socket) do
    {
      :noreply,
      apply_action(socket, socket.assigns.live_action, params)
    }
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit User admin")
    |> assign(:user, FitnessUsers.get_fitness_user!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New User admin")
    |> assign(:user, %FitnessUser{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "All Users")
    |> assign(:user, nil)
  end

  @impl true
  def handle_info({LangChainDemoWeb.UserAdminLive.FormComponent, {:saved, user}}, socket) do
    {:noreply, stream_insert(socket, :users, user)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    user = FitnessUsers.get_fitness_user!(id)
    {:ok, _} = FitnessUsers.delete_fitness_user(user)

    {:noreply, stream_delete(socket, :users, user)}
  end
end
