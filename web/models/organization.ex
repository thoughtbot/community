defmodule Community.Organization do
  use Community.Web, :model
  alias Community.Validations

  schema "organizations" do
    field :admin_email_address, :string
    field :name, :string
    field :no_reply_email_address, :string
    field :short_description, :string
    field :twitter, :string
    field :upcoming_meetups_url, :string
    field :logo_url, :string
    field :dribbble_enabled, :boolean, default: true
    field :meetup_enabled, :boolean, default: true

    timestamps()
  end

  @required_fields ~w(
    admin_email_address
    logo_url
    name
    no_reply_email_address
    short_description
  )a

  @optional_fields ~w(
    twitter
    upcoming_meetups_url
    dribbble_enabled
    meetup_enabled
  )a

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> Validations.email_format(:no_reply_email_address)
    |> Validations.email_format(:admin_email_address)
  end

  def placeholder_organization do
    %{
      admin_email_address: "admin@example.com",
      logo_url: "https://raw.githubusercontent.com/thoughtbot/community/master/web/static/assets/images/logo.png",
      name: "Sample Organization",
      no_reply_email_address: "no-reply@example.com",
      short_description: "A great resource for local groups to organize events and people",
      twitter: "raleighdesignio",
      upcoming_meetups_url: "",
    }
  end
end
