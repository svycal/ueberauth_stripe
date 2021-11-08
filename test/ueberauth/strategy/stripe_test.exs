defmodule Ueberauth.Strategy.StripeTest do
  use ExUnit.Case, async: true

  use Plug.Test

  import Mox

  @provider_config Keyword.get(Application.get_env(:ueberauth, Ueberauth)[:providers], :stripe)

  describe "handle_request!/1" do
    test "passes the correct data to the OAuth request" do
      authorize_url = "https://stripeapi.test"

      expect(OAuthMock, :authorize_url!, fn params, opts ->
        assert params == []
        assert opts == [{:redirect_uri, "http://www.example.com/auth/stripe/callback"}]
        authorize_url
      end)

      conn =
        conn(:get, "/", %{})
        |> Ueberauth.run_request(:stripe, @provider_config)

      assert %Plug.Conn{
               private: %{
                 ueberauth_request_options: %{
                   callback_methods: ["GET"],
                   callback_path: "/auth/stripe/callback",
                   request_path: "/auth/stripe",
                   strategy: Ueberauth.Strategy.Stripe,
                   strategy_name: :stripe
                 }
               },
               resp_headers: [
                 {"cache-control", "max-age=0, private, must-revalidate"},
                 {"location", ^authorize_url}
               ],
               scheme: :http,
               script_name: [],
               secret_key_base: nil,
               state: :sent,
               status: 302
             } = conn
    end
  end
end
