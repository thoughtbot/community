defmodule Community.Job do
  use Community.Web, :model
  import Ecto.Query

  schema "jobs" do
    field :title, :string
    field :company, :string
    field :contact, :string
    field :city, :string
    field :company_url, :string
    field :description, :string
    field :instructions, :string
    field :approved, :boolean, default: false
    field :preview, :boolean, default: false
    field :token, Ecto.UUID, default: Ecto.UUID.generate

    timestamps
  end

  @required_fields [
    :contact,
    :city,
    :company,
    :company_url,
    :description,
    :instructions,
    :title,
  ]

  @optional_fields [
    :approved,
    :preview,
  ]

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields)
    |> validate_format(:company_url, ~r/http(s)?.*/, message: "must start with http(s)")
    |> validate_required(@required_fields)
  end

  def admin_changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_format(:company_url, ~r/http(s)?.*/, message: "must start with http(s)")
    |> validate_required(@required_fields)
  end

  def approved(model) do
    where(model, approved: true)
  end
end
