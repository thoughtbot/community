defmodule Community.AcceptanceCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Hound.Helpers

      import Ecto.Model
      import Ecto.Query, only: [from: 2]
      import Community.Router.Helpers

      alias Community.Repo

      @endpoint Community.Endpoint

      hound_session
    end
  end

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Community.Repo)
  end
end
