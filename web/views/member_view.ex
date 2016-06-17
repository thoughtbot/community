defmodule Community.MemberView do
  use Community.Web, :view
  @gravatar_host "https://secure.gravatar.com/avatar/"
  @gravatar_size_query_param "?s=96"

  def gravatar(email) do
    @gravatar_host <> hash_email(email) <> @gravatar_size_query_param
  end

  defp hash_email(email) do
    email
    |> String.downcase
    |> String.strip
    |> md5_hash
  end

  def present?(nil) do
    false
  end

  def present?(string) do
    String.length(string) > 0
  end

  defp md5_hash(email) do
    :crypto.hash(:md5, email)
    |> Base.encode16(case: :lower)
  end

  def twitter_url(handle) do
    "https://twitter.com/" <> handle
  end

  def dribbble_url(username) do
    "https://dribbble.com/" <> username
  end
end
