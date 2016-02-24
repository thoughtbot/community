defmodule Community.SharedView do
  use Community.Web, :view

  def display_errors?(changeset) do
    changeset.errors != [] && changeset.changes != %{}
  end

  def svg(name) do
    raw render "_#{name}.svg"
  end
end
