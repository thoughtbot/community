use Mix.Config

config :community, :organization, %{
  admin_email_address: "admin@example.com",
  city: "Raleigh",
  logo_url: "https://raw.githubusercontent.com/thoughtbot/community/master/web/static/assets/images/logo.png",
  name: "Sample Organization",
  no_reply_email_address: "no-reply@example.com",
  short_description: "A great resource for local groups to organize events and people.",
  titles: "User Experience, User Interface, and visual designers",
  twitter: "raleighdesignio",
  upcoming_meetups_url: "https://api.meetup.com/self/calendar?photo-host=public&page=20&sig_id=205839672&sig=57e1d519c30c3e5f331d36feab8bebab7fbe494e",
}
