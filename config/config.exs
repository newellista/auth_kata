# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :auth_kata,
  ecto_repos: [AuthKata.Repo]

# Configures the endpoint
config :auth_kata, AuthKataWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "a3RccSK52xoixA6lB6oQ4pVyMUFOARBVKsryf93umrB++g1Las9rI/yLGItgqflg",
  render_errors: [view: AuthKataWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: AuthKata.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
