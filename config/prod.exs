import Config

# Do not print debug messages in production
config :logger, level: :info

# config :account_manager, AccountManagerWeb.Endpoint, force_ssl: [rewrite_on: [:x_forwarded_proto]]

# Runtime production configuration, including reading
# of environment variables, is done on config/runtime.exs.
