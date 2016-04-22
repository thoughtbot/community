defmodule Community.Queries.Job do
  alias Community.Job
  alias Community.Repo

  def approved_jobs do
    Job
    |> Job.approved
    |> Repo.all
  end
end
