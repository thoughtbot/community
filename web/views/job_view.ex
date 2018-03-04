defmodule Community.JobView do
  use Community.Web, :view

  def sanitize(text) do
    HtmlSanitizeEx.basic_html(text)
  end

  def can_edit?(job, token) do
    job.token == token
  end

  def trix_input(form, field_name, attrs \\ []) do
    connected_trix_input(form, field_name) ++
      trix_tag(field_name, attrs)
  end

  defp connected_trix_input(form, field_name) do
    [
      label(form, field_name),
      text_input(form, field_name, id: field_name, style: "display:none"),
    ]
  end

  defp trix_tag(field_name, attrs) do
    [
      content_tag(
        :"trix-editor",
        "",
        input: field_name,
        id: field_name,
        class: "trix-content #{attrs[:class]}",
        placeholder: attrs[:placeholder]
      )
    ]
  end
end
