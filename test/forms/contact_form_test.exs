defmodule Community.ContactFormTest do
  use Community.ModelCase
  alias Community.ContactForm

  @valid_attributes %{
    email: "tom@example.com",
    body: "HI",
    subject: "looking for a new gig?",
    member: "sally@example.com",
  }

  test "requires a valid email" do
    attributes = %{@valid_attributes | email: "jason"}
    changeset = ContactForm.changeset(%ContactForm{}, attributes)

    refute changeset.valid?
    [email: {email_error, _}] = changeset.errors
    assert email_error == "is invalid"
  end
end
