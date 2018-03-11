[![Stories in Ready](https://badge.waffle.io/thoughtbot/community.svg?label=ready&title=Ready)](http://waffle.io/thoughtbot/community)
[![CircleCI](https://circleci.com/gh/thoughtbot/community.svg?style=svg)](https://circleci.com/gh/thoughtbot/community)
# Community

## What is Community?

Community is an Elixir/Phoenix app that was designed primarily to run [Raleigh
Design]. Feel free to fork it and use it for your own community!

Right now it is very early MVP. Only the basic requirements are implemented and
a lot of "features" are handled manually.

[Raleigh Design]: https://raleighdesign.io

## Features

* Member directory

  * Approval is required for new members
  * Members can update and delete their own profiles
  * All authentication is handled via tokenized links
  * Admins can edit member profiles

* Job Board

  * Posting new jobs requires approval
  * Job authors can preview before submitting
  * Job authors can edit and delete their own posts
  * All authentication is handled via tokenized links

## Usage

Fork this repo, clone your forked repo locally, and change
`config/organization.exs` to suit your community. If you'd like to keep
up with upstream changes, then add an upstream remote and rebase from
the upstream remote periodically when you want to update. At this point,
it's easy to deploy to Heroku or any other hosting solution.

For example:

    % git clone your_forked_community_repo
    % git remote add upstream git@github.com:thoughtbot/community.git

    #...some time later...

    % git rebase upstream/master
    # You may have to reconcile any changes in 'config/organization.exs'
    % git push --force-with-lease

    # To deploy with heroku

    % heroku git:remote -a your-heroku-app -r production
    % git push production master

## Development and Contribuing

See [Contributing](CONTRIBUTING.md)

## About thoughtbot

![thoughtbot](https://thoughtbot.com/logo.png)

Community is maintained and funded by thoughtbot, inc.
The names and logos for thoughtbot are trademarks of thoughtbot, inc.

Community is part of the [thoughtbot Elixir family][elixir-phoenix] of
projects.

We love open source software! See [our other projects][community] or
[hire us] to design, develop, and grow your product.

[elixir-phoenix]: https://thoughtbot.com/services/elixir-phoenix?utm_source=github
[community]: https://thoughtbot.com/community?utm_source=github
[hire us]: https://thoughtbot.com?utm_source=github
