# Contributing

We love pull requests from everyone.  By participating in this project,
you agree to abide by the thoughtbot [code of conduct].

  [code of conduct]: https://thoughtbot.com/open-source-code-of-conduct

We expect everyone to follow the code of conduct anywhere in
thoughtbot's project codebases, issue trackers, chatrooms, and mailing
lists.

## Getting Started

After you have cloned this repo, run this setup script to set up your machine
with the necessary dependencies to run and test this app:

    % ./bin/setup

It assumes you have a machine equipped with [asdf], [asdf-elixir], [asdf-erlang],
[asdf-nodejs], [phantomjs], and [postgres].

Start the server using

    % mix phx.server
    # or
    % ./bin/server

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

When you run `bin/setup`, the database will automatically be populated with a
set of development data that should make playing around with the app locally
easy.

[asdf]: https://github.com/asdf-vm/asdf
[asdf-elixir]: https://github.com/asdf-vm/asdf-elixir
[asdf-erlang]: https://github.com/asdf-vm/asdf-erlang
[asdf-nodejs]: https://github.com/asdf-vm/asdf-nodejs
[postgres]: http://postgresapp.com/
[phantomjs]: http://phantomjs.org/

## Development Seeds

In `lib/mix/tasks/development_seeds.ex` you will find a mix task for seeding the
app with development data. For an explanation of how we use development seeds,
please read this [blog post].

To run the seeds:

    % mix development_seeds

It's recommended to regularly run the seeds so that you're not relying on data
you created by hand. To make this easier, the `bin/server` command will
automatically reset your db seeds each time you restart the server.

[blog post]: https://robots.thoughtbot.com/priming-the-pump

## Tests

You can run the tests using:

    % ./bin/test_suite

## Email

We use [Bamboo] for sending email which has a great feature where it stores all
mail sent during development and allows you to view it in the browser.

To access the sent emails, navigate to
[http://localhost:4000/sent_emails](http://localhost:4000/sent_emails).

[Bamboo]: http://github.com/thoughtbot/bamboo

## New Features

* If you don't see an issue already for the feature you're looking to add,
  please open an issue first to see if it is something we'd like to implement.
  We love new features but hate to have people spend time on something that
  doesn't fit the app.
* Please add tests for any new feature. If you're having trouble figuring out to
  test something, please open an issue. We're happy to help out!

## Useful Links

* [CircleCI](https://circleci.com/gh/thoughtbot/community)
* [GitHub](https://github.com/thoughtbot/community)
