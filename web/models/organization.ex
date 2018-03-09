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
    titles
    no_reply_email_address
    short_description
  )a

  @optional_fields ~w(
    twitter
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
    |> validate_twitter
    |> validate_required(@required_fields)
    |> Validations.email_format(:no_reply_email_address)
    |> Validations.email_format(:admin_email_address)
    |> Validations.url_format(:logo_url)
    |> Validations.url_format(:upcoming_meetups_url)
  end

  defp validate_twitter(changeset) do
    case get_field(changeset, :twitter) do
      nil ->
        changeset

      twitter ->
        if String.contains?(twitter, "@") do
          changeset
          |> add_error(:twitter, "Twitter handle doesn't need to contain @ symbol")
        else
          changeset
        end
    end
  end
end
