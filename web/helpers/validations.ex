defmodule Community.Validations do
  import Ecto.Changeset

  def validate_url_format(changeset, field) do
    url_format = ~r/http(s)?.*/
    message = "must start with http(s)"

    if get_field(changeset, field) in ["", nil] do
      changeset
    else
      validate_format(changeset, field, url_format, message: message)
    end
  end

  def validate_email_format(changeset, field) do
    changeset
    |> validate_format(field, ~r/.+\@.+\..+/, message: "is invalid")
  end
end
