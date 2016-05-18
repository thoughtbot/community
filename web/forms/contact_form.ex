defmodule Community.ContactForm do
  use Community.Web, :model

  embedded_schema do
    field :body
    field :email
    field :subject
    field :member
  end

  @required_fields [
    :body,
    :email,
    :member,
    :subject,
  ]

  @optional_fields [
  ]

  def changeset(model, params \\ %{})
  def changeset(model, params) do
    model
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
  end
end
