defmodule Community.FeatureHelpers do
  use Hound.Helpers
  import Community.RoleHelpers

  def click_on(text) do
    find_element(:link_text, text)
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

  def ignore_confirm_dialog do
    execute_script("window.confirm = function(){return true;}")
  end
end
