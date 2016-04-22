defmodule Community.FeatureHelpers do
  use Hound.Helpers

  def click_on(text) do
    find_element(:link_text, text)
    |> click
  end

  def click_role(name) do
    find_element(:css, "[data-role=#{name}]")
    |> click
  end

  def fill_in(type, field_name, [with: text]) do
    fill_field({:name, "#{type}[#{field_name}]"}, text)
  end

  def flash_text do
    text_for_role("flash")
  end

  def submit do
    submit_element({:css, "input[type=submit]"})
  end

  def find_role(role_name) do
    find_all_elements(:css, "[data-role=#{role_name}]")
  end

  def find_role(element, role_name) do
    find_within_element(element, :css, "[data-role=#{role_name}]")
  end

  def text_for_role(role_name) do
    role_name
    |> find_role
    |> show_text_for_all_roles(role_name)
  end

  def show_text_for_all_roles(elements, _) when length(elements) > 0 do
    text_for_elements(elements)
  end

  def text_for_elements(elements) when length(elements) == 0 do
    ""
  end

  def text_for_elements(elements) do
    elements
    |> Enum.map(&visible_text(&1))
    |> Enum.join(" ")
  end
end
