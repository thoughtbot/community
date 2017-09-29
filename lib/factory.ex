defmodule Community.Factory do
  use ExMachina.Ecto, repo: Community.Repo

  def job_factory do
    %Community.Job{
      approved: false,
      city: "Raleigh",
      contact: sequence(:contact, &"contact-#{&1}@example.com"),
      company: "thoughtbot",
      application_url: "http://www.example.com",
      title: "title",
    }
  end

  def member_factory do
    %Community.Member{
      approved: false,
      title: "designer at thoughtbot",
      email: sequence(:email, &"email-#{&1}@example.com"),
      name: "Ralph Robot",
      website: "http://ralph.thoughtbot.com",
    }
  end

  def approve(job) do
    %{job | approved: true}
  end
end
