defmodule AccountManagerWeb.Router do
  use AccountManagerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug AccountManagerWeb.AuthPlug
  end

  pipeline :token_acess do
    plug AccountManagerWeb.TokenPlug
  end

  scope "/api", AccountManagerWeb do
    pipe_through :api

    post "/users/login", UsersController, :login
  end

  scope "/api", AccountManagerWeb do
    pipe_through [:api, :token_acess]

    post "/users", UsersController, :create
  end

  scope "/api", AccountManagerWeb do
    pipe_through [:api, :auth]

    get "/users/", UsersController, :show
    delete "/users/", UsersController, :delete
  end

  # Enable LiveDashboard in development
  if Application.compile_env(:account_manager, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: AccountManagerWeb.Telemetry
    end
  end
end
