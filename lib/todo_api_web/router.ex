defmodule TodoApiWeb.Router do
  import TodoApiWeb.Authentication

  use TodoApiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {TodoApiWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticated do
    plug :ensure_authenticated
  end

  # Other scopes may use custom stacks.
  scope "/api", TodoApiWeb do
    pipe_through :api

    post "/user/register", UserController, :register

    post "/session", SessionController, :create
    delete "/session", SessionController, :destroy
  end

  scope "/api", TodoApiWeb do
    pipe_through([:authenticate_header, :authenticated])
    resources "/lists", ListController do
      # The user should be able to add a task to the TODO list
      # The user should be able to remove a task from the TODO list
      # The user should be able to update the details of a task in the TODO list
      resources "/tasks", TaskController, only: [:index, :create, :show, :update, :delete]
    end

    # The user should be able to reorder the tasks in the TODO list
    resources "/lists", ListController, only: [:update]

    # A task in the TODO list should be able to handle being moved more than 50 times
    # A task in the TODO list should be able to handle being moved to more than one task away from its current position

    get "/user", UserController, :index
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: TodoApiWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
