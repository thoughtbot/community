defmodule Community.SharedView do
  use Community.Web, :view

  def display_errors?(changeset) do
    changeset.errors != [] && changeset.changes != %{}
  end
end
