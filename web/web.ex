defmodule Community.Web do
  @moduledoc """
  A module that keeps using definitions for controllers,
  views and so on.

  This can be used in your application as:

      use Community.Web, :controller
      use Community.Web, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below.
  """

  def model do
    quote do
      use Ecto.Schema

      import Ecto
      import Ecto.Changeset
      import Ecto.Query, only: [from: 1, from: 2]
    end
  end

  def controller do
    quote do
      use Phoenix.Controller

      alias Community.Repo
      import Ecto
      import Ecto.Query, only: [from: 1, from: 2]

      import Community.Router.Helpers
      import Community.Gettext
    end
  end

  def view do
    quote do
      use Phoenix.View, root: "web/templates"

      def render_embeddable(module, template, assigns) do
        if assigns[:inner] do
          assigns.inner
        else
          render module, template, assigns
        end
      end

      def within(_layout, template, assigns, do: contents) do
        assigns = Map.put(assigns, :inner, contents)
        render_template(template, assigns)
      end

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import Formulator
      import Community.Router.Helpers
      import Community.ErrorHelpers
      import Community.Gettext
    end
  end

  def router do
    quote do
      use Phoenix.Router
    end
  end

  def channel do
    quote do
      use Phoenix.Channel

      alias Community.Repo
      import Ecto
      import Ecto.Query, only: [from: 1, from: 2]
      import Community.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
