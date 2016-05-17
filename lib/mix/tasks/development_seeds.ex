defmodule Mix.Tasks.DevelopmentSeeds do
  use Mix.Task
  import Community.Factory

  @shortdoc "Insert the seeds for development"

  def run(_args) do
    Mix.Task.run "ecto.drop", []
    Mix.Task.run "ecto.create", []
    Mix.Task.run "ecto.migrate", []
    Mix.Task.run "app.start", []

    approve_member(%{
      name: "Sam Seaborn",
      company_name: "Sam's construction",
      twitter_handle: "samsconstruction",
    })
    approve_member(%{
      name: "Michelangelo",
      company_name: "Mike's Pizza",
      dribbble_username: "Mikey",
    })
    approve_member(%{
      name: "Scott Summers",
      company_name: "Cyclops Shades",
    })
    approve_member(%{
      name: "Wade Wilson",
      company_name: "Mercs for Hire",
    })
    approve_member(%{
      name: "Bruce Banner",
      company_name: "University of California, LA",
    })

    for title <- titles do
      create(
        :job,
        approved: true,
        company: Enum.random(companies),
        title: "#{title}"
      )
    end

    create(:job, title: "Awsesome Designer")
    create(:job, title: "Rockstar")
  end

  def titles do
    [
      "Lead Designer",
      "Design Ninja",
      "Junior Designer",
      "Digital Designer",
      "Product Designer"
    ]
  end

  def companies do
    [
      "thoughtbot",
      "Vista",
      "Microsoft",
      "Citrix",
      "WebAssign",
      "BigLeap",
      "EA",
      "Big Corp",
    ]
  end

  def approve_member(attributes) do
    build(:member, attributes) |> approve |> create
  end
end
