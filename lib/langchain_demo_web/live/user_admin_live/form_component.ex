defmodule LangChainDemoWeb.UserAdminLive.FormComponent do
  use LangChainDemoWeb, :live_component

  alias LangChainDemo.FitnessUsers

  @impl true
  def update(%{user: user} = assigns, socket) do
    changeset = FitnessUsers.change_fitness_user(user)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"user" => user_params}, socket) do
    changeset =
      socket.assigns.user
      |> FitnessUsers.change_fitness_user(user_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"user" => user_params}, socket) do
    save_user(socket, socket.assigns.action, user_params)
  end

  defp save_user(socket, :edit, user_params) do
    case FitnessUsers.update_fitness_user(socket.assigns.user, user_params) do
      {:ok, user} ->
        notify_parent({:saved, user})

        {:noreply,
         socket
         |> put_flash(:info, "User admin updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_user(socket, :new, user_params) do
    case FitnessUsers.create_fitness_user(user_params) do
      {:ok, user} ->
        notify_parent({:saved, user})

        {:noreply,
         socket
         |> put_flash(:info, "User admin created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset, as: :user))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage user records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="user-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:age]} type="number" label="Age" />

        <.input field={@form[:overall_fitness_plan]} type="text" label="Overall fitness plan" />

        <.input field={@form[:fitness_experience]} type="text" label="Fitness experience" />

        <.input field={@form[:gender]} type="text" label="Gender" />

        <.input field={@form[:goals]} type="text" label="Goals" />

        <.input field={@form[:name]} type="text" label="Name" />

        <.input field={@form[:resources]} type="text" label="Resources" />

        <.input field={@form[:why]} type="text" label="Why" />

        <.input field={@form[:limitations]} type="text" label="Limitations" />
        <.input field={@form[:notes]} type="text" label="Notes" />

        <.input field={@form[:fitness_plan_for_week]} type="text" label="Fitness plan for week" />
        <.input field={@form[:timezone]} type="text" label="Timezone" />
        <:actions>
          <.button phx-disable-with="Saving...">Save User admin</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end
end
