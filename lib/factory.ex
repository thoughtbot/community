defmodule Community.Factory do
  use ExMachina.Ecto, repo: Community.Repo

  def factory(:job) do
    %Community.Job{
      approved: true,
      city: "some content",
      company: "some content",
      company_url: "http://www.example.com",
      description: "some content",
      instructions: "some content",
      preview: true,
      title: "title",
    }
  end
end
