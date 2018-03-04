defmodule Community.Factory do
  use ExMachina.Ecto, repo: Community.Repo

  def organization_factory do
    %Community.Organization{
      admin_email_address: "admin@example.com,admin@raleighdesign.io",
      name: "Raleigh Design",
      no_reply_email_address: "noreply@raleighdesign.io",
      short_description: "A resource for designers in Raleigh to stay connected and find prospective career opportunities.",
      twitter: "raleighdesignio",
      upcoming_meetups_url: "https://api.meetup.com/self/calendar?photo-host=public&page=20&sig_id=205839672&sig=57e1d519c30c3e5f331d36feab8bebab7fbe494e",
    }
  end

  def job_factory do
    %Community.Job{
      approved: false,
      city: "Raleigh",
      contact: sequence(:contact, &"contact-#{&1}@example.com"),
      company: "thoughtbot",
      company_url: "http://www.example.com",
      description: "A great job",
      instructions: "SIGN UP NOW!",
      preview: true,
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
