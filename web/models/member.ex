defmodule Community.Member do
  use Community.Web, :model
  import Ecto.Query
  alias Community.Validations

  schema "members" do
    field :name, :string
    field :email, :string
    field :title, :string
    field :approved, :boolean, default: false
    field :website, :string
    field :twitter_handle, :string
    field :dribbble_username, :string
    field :social_media, :string, virtual: true

    timestamps
  end

  @allowed_fields [
    :dribbble_username,
    :email,
    :name,
    :title,
    :twitter_handle,
    :website,
  ]

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @allowed_fields)
    |> validate_required([:name, :email, :title])
    |> Validations.validate_url_format(:website)
    |> validate_at_least_one_present([:website, :twitter_handle, :dribbble_username], "you must provide at least one social media contact")
  end

  defp validate_at_least_one_present(changeset, fields, error) do
    if any_field_present?(changeset, fields) do
      changeset
    else
      add_error(changeset, :social_media, error)
    end
  end

  defp any_field_present?(changeset, fields) do
    Enum.any? fields, fn (field) ->
      changeset |> get_field(field) |> present?
    end
  end

  defp present?(nil), do: false
  defp present?(string), do: String.length(string) > 1

  def approved(model) do
    where(model, approved: true)
  end
end
