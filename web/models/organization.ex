defmodule Community.Organization do
  use Community.Web, :model
  alias Community.Validations

  schema "organizations" do
    field :admin_email_address, :string
    field :meetup_slugs, {:array, :string}
    field :name, :string
    field :no_reply_email_address, :string
    field :short_description, :string
    field :twitter, :string

    timestamps()
  end

  @required_fields ~w(
    admin_email_address
    name
    no_reply_email_address
    short_description
  )a

  @optional_fields ~w(
    meetup_slugs
    twitter
  )a

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> Validations.validate_email_format(:no_reply_email_address)
    |> Validations.validate_email_format(:admin_email_address)
  end

  def placeholder_organization do
    %{
      admin_email_address: "admin@example.com",
      name: "Sample Organization",
      no_reply_email_address: "no-reply@example.com",
      short_description: "A great resource for local groups to organize events and people",
      meetup_slugs: ["refreshthetriangle", "triangle-elixir"],
      twitter: "raleighdesignio"
    }
  end
end
