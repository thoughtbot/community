defmodule Community.Job do
  use Community.Web, :model
  import Ecto.Query
  alias Community.Validations

  schema "jobs" do
    field :application_url, :string
    field :approved, :boolean, default: false
    field :city, :string
    field :company, :string
    field :contact, :string
    field :title, :string
    field :token, Ecto.UUID, default: Ecto.UUID.generate

    timestamps()
  end

  @required_fields [
    :application_url,
    :city,
    :company,
    :contact,
    :title,
  ]

  @optional_fields [
    :approved,
  ]

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields)
    |> Validations.validate_url_format(:application_url)
    |> Validations.validate_email_format(:contact)
    |> validate_required(@required_fields)
  end

  def admin_changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> Validations.validate_url_format(:application_url)
    |> validate_required(@required_fields)
  end

  def approved(model) do
    where(model, approved: true)
  end
end
