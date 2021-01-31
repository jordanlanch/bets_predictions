# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :scrapping_bet,
  ecto_repos: [ScrappingBet.Repo]

# Configures the endpoint
config :scrapping_bet, ScrappingBetWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "jUvMu5trd5cIPmUU6RhytyPbVc5YQ8yElJRakQui3VXnOj5Z38J5TxLkA3jvqIkg",
  render_errors: [view: ScrappingBetWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ScrappingBet.PubSub,
  live_view: [signing_salt: "meq1h0Fr"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :scrapping_bet, ScrappingBet.Scheduler,
  jobs: [
    {"* * * * *", {ScrappingBet.Scrapper.Scrapper, :get_smoothies_url, []}},
  ]

config :scrapping_bet, ScrappingBetWeb.Endpoint,
  live_view: [signing_salt: "oP4z5yzg1UBo5xaB+euFF7tQ4n9GvpR2"]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
