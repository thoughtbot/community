defmodule Community.Member do
  use Community.Web, :model
  import Ecto.Query

  schema "members" do
    field :name, :string
    field :email, :string
    field :company_name, :string
    field :approved, :boolean, default: false

    timestamps
  end

  @allowed_fields ~w(name email company_name)
  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @allowed_fields)
    |> validate_required(:name)
    |> validate_required(:email)
    |> validate_required(:company_name)
  end

  def approved(model) do
    where(model, approved: true)
  end
end
