defmodule Community.Repo do
  use Ecto.Repo, otp_app: :community
  use Scrivener, page_size: 50
end
