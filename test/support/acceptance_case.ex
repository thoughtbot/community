defmodule Community.AcceptanceCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Hound.Helpers

      import Ecto.Model
      import Ecto.Query, only: [from: 2]
      import Community.Router.Helpers
      import Community.Factory
      import Community.FeatureHelpers
      import Community.RoleHelpers

      alias Community.Repo

      @endpoint Community.Endpoint
    end
  end

  setup _tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Community.Repo)
    Hound.start_session()
    path = Community.Phoenix.Ecto.SQL.Sandbox.path_for(Community.Repo, self())
    Hound.Helpers.Navigation.navigate_to(path)
    :ok
  end
end
