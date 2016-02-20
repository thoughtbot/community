Application.ensure_all_started(:hound)
ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Community.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Community.Repo --quiet)
Ecto.Adapters.SQL.Sandbox.mode(Community.Repo, :manual)
