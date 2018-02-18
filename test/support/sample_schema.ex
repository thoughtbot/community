defmodule Community.Test.SampleSchema do
  import Ecto.Changeset
  use Ecto.Schema

  embedded_schema do
    field :name, :string
    field :email_address, :string
    field :url, :string
  end

  def changeset(schema \\ %__MODULE__{}, attrs) do
    schema
    |> cast(attrs, [:name, :email_address, :url])
  end
end
