# Contributing

We love pull requests from everyone.
By participating in this project,
you agree to abide by the thoughtbot [code of conduct].

  [code of conduct]: https://thoughtbot.com/open-source-code-of-conduct

We expect everyone to follow the code of conduct
anywhere in thoughtbot's project codebases,
issue trackers, chatrooms, and mailing lists.

## Developing

After you have cloned this repo, run this setup script to set up your machine
with the necessary dependencies to run and test this app:

    % ./bin/setup

It assumes you have the following:

* Postgresql
* Elixir
* PhantomJS

Start the server using

    % mix phoenix.server

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

When you run `bin/setup`, the database will automatically be populated with a
set of development data that should make playing around with the app locally
easy.

## Tests

You can run the tests using:

    % ./bin/setup

this will start up PhantomJS in webdriver mode and run your test suite.

If you want to run feature tests individually, you can start phantomjs manually:

    % phantomjs --wd

then you can run the tests as you would normally:

    % mix test test/features/example_test.ex

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
