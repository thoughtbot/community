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

  @allowed_fields ~w(title company city company_url description instructions approved preview)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :invalid) do
    model
    |> cast(params, @allowed_fields)
    |> validate_format(:company_url, ~r/http(s)?.*/, message: "must start with http(s)")
    |> validate_required(:city)
    |> validate_required(:company)
    |> validate_required(:company_url)
    |> validate_required(:description)
    |> validate_required(:instructions)
    |> validate_required(:title)
  end

  def approved(model) do
    where(model, approved: true)
  end
end
