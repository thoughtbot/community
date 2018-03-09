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
    field :city, :string
    field :logo_url, :string

    timestamps()
  end

  @required_fields ~w(
    admin_email_address
    city
    logo_url
    name
    no_reply_email_address
    short_description
  )a

  @optional_fields ~w(
    twitter
    upcoming_meetups_url
  )a

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields ++ @optional_fields)
    |> format_twitter
    |> validate_required(@required_fields)
    |> Validations.email_format(:no_reply_email_address)
    |> Validations.email_format(:admin_email_address)
    |> Validations.url_format(:logo_url)
    |> Validations.url_format(:upcoming_meetups_url)
  end

  defp format_twitter(changeset) do
    case get_change(changeset, :twitter) do
      nil ->
        changeset

      twitter ->
        formatted_twitter = String.replace(twitter, "@", "", global: true)
        changeset
        |> put_change(:twitter, formatted_twitter)
    end
  end

  def placeholder_organization do
    %{
      admin_email_address: "admin@example.com",
      city: "Raleigh",
      logo_url: "https://raw.githubusercontent.com/thoughtbot/community/master/web/static/assets/images/logo.png",
      name: "Sample Organization",
      no_reply_email_address: "no-reply@example.com",
      short_description: "A great resource for local groups to organize events and people",
      twitter: "raleighdesignio",
      upcoming_meetups_url: "https://api.meetup.com/self/calendar?photo-host=public&page=20&sig_id=205839672&sig=57e1d519c30c3e5f331d36feab8bebab7fbe494e",
    }
  end
end
