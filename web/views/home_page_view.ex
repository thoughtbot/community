defmodule Community.HomePageView do
  use Community.Web, :view

  def serialize_slugs(slugs) do
    slugs
    |> Enum.map(&(~s|"#{&1}"|))
    |> Enum.join(",")
    |> wrap_into_array
  end

  defp wrap_into_array(string), do: "[#{string}]"
end
