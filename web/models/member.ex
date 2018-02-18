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
    field :available_for_hire, :boolean, default: false
    field :token, Ecto.UUID, default: Ecto.UUID.generate

    timestamps()
  end

  @allowed_fields [
    :available_for_hire,
    :dribbble_username,
    :email,
    :name,
    :title,
    :twitter_handle,
    :website,
  ]

  @admin_fields [
    :approved,
  ]

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @allowed_fields)
    |> model_validations
  end

  def admin_changeset(model, params \\ %{}) do
    model
    |> cast(params, @allowed_fields, @admin_fields)
    |> model_validations
  end

  defp model_validations(changset) do
    changset
    |> validate_required([:name, :email, :title])
    |> unique_constraint(:email)
    |> Validations.url_format(:website)
    |> Validations.email_format(:email)
    |> Validations.at_least_one_present(
      :social_media,
      [:website, :twitter_handle, :dribbble_username],
      message: "you must provide at least one social media contact"
    )
  end

  def approved(model) do
    where(model, approved: true)
  end
end
