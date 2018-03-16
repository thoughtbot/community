defmodule Community.Organization do
  use Community.Web, :model
  alias Community.Validations

  defmodule BuildError do
    defexception [:message]
  end

  schema "organizations" do
    field :admin_email_address, :string
    field :name, :string
    field :no_reply_email_address, :string
    field :short_description, :string
    field :sponsers, :string
    field :twitter, :string
    field :upcoming_meetups_url, :string
    field :city, :string
    field :titles, :string
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
    sponsers
    titles
    twitter
  )a

  @optional_fields ~w(
    upcoming_meetups_url
  )a

  def build do
    changeset = Application.get_env(:community, :organization) |> changeset
    if changeset.valid? do
      changeset |> apply_changes
    else
      raise BuildError, message:
        """
        Organization is not valid.
        Errors: #{inspect changeset.errors}
        """
    end
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> Validations.twitter_handle(:twitter)
    |> Validations.email_format(:no_reply_email_address)
    |> Validations.email_format(:admin_email_address)
    |> Validations.url_format(:logo_url)
    |> Validations.url_format(:upcoming_meetups_url)
  end
end
