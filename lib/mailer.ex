defmodule Community.Mailer do
  def deliver(email) do
    Mailman.deliver(email, config)
  end

  def config do
    %Mailman.Context{
      config:   %Mailman.LocalSmtpConfig{ port: 25 },
      composer: %Mailman.EexComposeConfig{}
    }
  end

  def smtp_config do
    %Mailman.SmtpConfig{
      port: 25,
    }
  end
  def testing_email do
    %Mailman.Email{
      subject: "Hello Mailman!",
      from: "something@somewhere.com",
      to: ["something@somewhere.com"],
      data: [
        name: "Yo"
      ],
      text: "Hello! These are Unicode: qżźół",
      html: """
      <html>
      <body>
      <b>Hello! These are Unicode: qżźół
      </body>
      </html>
      """
    }
  end
end
