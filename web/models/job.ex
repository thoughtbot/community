defmodule Community.Job do
  use Community.Web, :model
  import Ecto.Query

  schema "jobs" do
    field :title, :string
    field :company, :string
    field :city, :string
    field :company_url, :string
    field :description, :string
    field :instructions, :string
    field :approved, :boolean, default: false
    field :preview, :boolean, default: false

    timestamps
  end

  @required_fields ~w(title company city company_url description instructions approved preview)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_format(:company_url, ~r/http(s)?.*/, message: "must start with http(s)")
  end

  def approved(model) do
    where(model, approved: true)
  end
end
