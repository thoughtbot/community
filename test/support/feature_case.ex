defmodule Community.FeatureCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Hound.Helpers

      import Ecto.Schema, except: [build: 2]
      import Ecto.Query, only: [from: 2]
      import Community.Router.Helpers
      import Community.Factory
      import Community.FeatureHelpers
      import Community.RoleHelpers

      alias Community.Repo

      @endpoint Community.Endpoint
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Community.Repo)

    on_exit(fn ->
      PhantomJS.clear_local_storage()
    end)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Community.Repo, {:shared, self()})
    end

    Hound.start_session()
    path = Community.Phoenix.Ecto.SQL.Sandbox.path_for(Community.Repo, self())
    Hound.Helpers.Navigation.navigate_to(path)
    {:ok,
      organization: Community.Factory.build(:organization)
    }
  end
end
