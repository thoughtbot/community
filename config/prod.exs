use Mix.Config

config :community, Community.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [scheme: "https", host: System.get_env("HOST"), port: 443],
  force_ssl: [rewrite_on: [:x_forwarded_proto]],
  cache_static_manifest: "priv/static/manifest.json",
  secret_key_base: System.get_env("SECRET_KEY_BASE")

config :logger, level: :info

config :community, Community.Mailer,
  adapter: Bamboo.MandrillAdapter,
  api_key: System.get_env("MANDRILL_API_KEY")

config :community, Community.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  pool_size: 10,
  ssl: true
