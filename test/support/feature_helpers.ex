defmodule Community.FeatureHelpers do
  use Hound.Helpers
  import Community.RoleHelpers

  def click_on(text) do
    text
    |> find_element_with_text
    |> click
  end

  def find_element_with_text(text) do
    case find_all_elements(:link_text, text) do
      [] -> find_element(:css, "input[value='#{text}']")
      [element] -> element
      _multiple_elements -> raise "Multiple elements found with the text #{text}"
    end
  end

  def fill_in(type, field_name, [with: text]) do
    fill_field({:name, "#{type}[#{field_name}]"}, text)
  end

  def flash_text do
    text_for_role("flash")
  end

  def submit do
    submit_element({:css, "button[type=submit]"})
  end

  def ignore_confirm_dialog do
    execute_script("window.confirm = function(){return true;}")
  end
end
