# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :community, Community.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "FL9oONkmlV9xZEwl80G0JGsBlnFSy5nWoaoT3+yq7vSHnKvgo9NreEbkZ24rqJND",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: Community.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :community, ecto_repos: [Community.Repo]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

config :hound, driver: "phantomjs"

config :formulator, translate_error_module: Community.ErrorHelpers

import_config "organization.exs"
