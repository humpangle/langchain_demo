defmodule LangChainDemoWeb.Router do
  use LangChainDemoWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {LangChainDemoWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LangChainDemoWeb do
    pipe_through :browser

    get "/", PageController, :home

    live "/conversations", ConversationLive.Index, :index
    live "/conversations/new", ConversationLive.Index, :new
    live "/conversations/:id/edit", ConversationLive.Index, :edit

    live "/conversations/:id", ConversationLive.Show, :show
    live "/conversations/:id/show/edit", ConversationLive.Show, :edit
    live "/conversations/:id/edit_message/:msg_id", ConversationLive.Show, :edit_message

    live "/agent_chat/", AgentChatLive.Index, :index

    live "/admin/users", UserAdminLive.Index, :index
    live "/admin/users/new", UserAdminLive.Index, :new
    live "/admin/users/:id/edit", UserAdminLive.Index, :edit

    live "/admin/users/:id", UserAdminLive.Show, :show
    live "/admin/users/:id/show/edit", UserAdminLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", LangChainDemoWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:langchain_demo, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: LangChainDemoWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
