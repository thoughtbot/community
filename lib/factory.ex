defmodule Community.Factory do
  use ExMachina.Ecto, repo: Community.Repo

  def factory(:job) do
    %Community.Job{
      approved: false,
      city: "Raleigh",
      company: "thoughtbot",
      company_url: "http://www.example.com",
      description: "A great job",
      instructions: "SIGN UP NOW!",
      preview: true,
      title: "title",
    }
  end

  def factory(:member) do
    %Community.Member{
      approved: false,
      company_name: "thoughtbot",
      email: sequence(:email, &"email-#{&1}@example.com"),
      name: "Ralph Robot",
    }
  end

  def approve(job) do
    %{job | approved: true}
  end
end
