defmodule LangChainDemoWeb.UserAdminLive.Show do
  use LangChainDemoWeb, :live_view

  alias LangChainDemo.FitnessUsers

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:user, FitnessUsers.get_fitness_user!(id))}
  end

  defp page_title(:show), do: "Show User admin"
  defp page_title(:edit), do: "Edit User admin"
end
