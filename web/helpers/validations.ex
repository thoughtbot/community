defmodule Community.Validations do
  import Ecto.Changeset

  def url_format(changeset, field) do
    url_format = ~r/http(s)?.*/
    message = "must start with http(s)"

    if get_field(changeset, field) in ["", nil] do
      changeset
    else
      validate_format(changeset, field, url_format, message: message)
    end
  end

  def email_format(changeset, field) do
    changeset
    |> validate_format(field, ~r/.+@.+..+/, message: "is invalid")
  end

  def at_least_one_present(changeset, field, fields, options \\ []) when is_list(fields) do
    default_message = "you must provide at least one of: #{Enum.join(fields, ", ")}"
    message = Keyword.get(options, :message, default_message)

    if any_field_present?(changeset, fields) do
      changeset
    else
      changeset
      |> add_error(field, message)
    end
  end

  defp any_field_present?(changeset, fields) do
    Enum.any? fields, fn (field) ->
      changeset |> get_field(field) |> present?
    end
  end

  defp present?(nil), do: false
  defp present?(string), do: String.length(string) > 1
end
