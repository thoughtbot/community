defmodule Community.Helpers.ValidationsTest do
  use Community.ModelCase
  alias Community.Validations
  alias Community.Test.SampleSchema

  describe "url_format/2" do
    test "when valid and http, returns changeset" do
      changeset =
        %SampleSchema{}
        |> SampleSchema.changeset(%{url: "http://example.com"})
        |> Validations.url_format(:url)

      assert changeset.valid?
    end

    test "when valid and https, returns changeset" do
      changeset =
        %SampleSchema{}
        |> SampleSchema.changeset(%{url: "https://example.com"})
        |> Validations.url_format(:url)

      assert changeset.valid?
    end

    test "when invalid, returns changeset with error" do
      changeset =
        %SampleSchema{}
        |> SampleSchema.changeset(%{url: "not a url"})
        |> Validations.url_format(:url)

      refute changeset.valid?
      assert changeset.errors[:url] == {"must start with http(s)", [validation: :format]}
    end
  end

  describe "email_format/2" do
    test "when valid, returns changeset" do
      changeset =
        %SampleSchema{}
        |> SampleSchema.changeset(%{email_address: "bob@example.com"})
        |> Validations.email_format(:email_address)

      assert changeset.valid?
    end

    test "when invalid, returns changeset with error" do
      changeset =
        %SampleSchema{}
        |> SampleSchema.changeset(%{email_address: "bob@example"})
        |> Validations.email_format(:email_address)

      refute changeset.valid?
      assert changeset.errors[:email_address] == {"is invalid", [validation: :format]}
    end
  end

  describe "at_least_one_present/3" do
    test "when valid, returns changeset" do
      changeset =
        %SampleSchema{}
        |> SampleSchema.changeset(%{email_address: "bob@example.com"})
        |> Validations.at_least_one_present(:name, [:name, :email_address])

      assert changeset.valid?
    end

    test "when invalid, returns changeset with error" do
      changeset =
        %SampleSchema{}
        |> SampleSchema.changeset(%{})
        |> Validations.at_least_one_present(:name, [:name, :email_address])

      refute changeset.valid?
      assert changeset.errors[:name] == {"you must provide at least one of: name, email_address", []}
    end

    test "when provided message, uses the message as error message" do
      changeset =
        %SampleSchema{}
        |> SampleSchema.changeset(%{})
        |> Validations.at_least_one_present(:name, [:name, :email_address], message: "test message")

      refute changeset.valid?
      assert changeset.errors[:name] == {"test message", []}
    end
  end
end
