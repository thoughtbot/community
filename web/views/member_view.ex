defmodule Community.MemberView do
  use Community.Web, :view
  @gravatar_host "https://secure.gravatar.com/avatar/"

  def gravatar(email) do
    @gravatar_host <> hash_email(email)
  end

  defp hash_email(email) do
     email
    |> String.downcase
    |> String.strip
    |> md5_hash
  end

  defp md5_hash(email) do
    :crypto.hash(:md5, email)
    |> Base.encode16(case: :lower)
  end
end
