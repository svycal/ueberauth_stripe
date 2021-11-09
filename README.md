# Überauth Stripe

> Stripe OAuth2 strategy for Überauth.

## Installation

1. Setup your application in your Stripe extension settings.

1. Add `:ueberauth_stripe` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:ueberauth_stripe, git: "git://github.com/svycal/ueberauth_stripe.git"}]
    end
    ```

1. Add Stripe to your Überauth configuration:

    ```elixir
    config :ueberauth, Ueberauth,
      providers: [
        stripe: {Ueberauth.Strategy.Stripe, []}
      ]
    ```

1.  Update your provider configuration:

    Use that if you want to read client ID/secret from the environment
    variables in the compile time:


    ```elixir
    config :ueberauth, Ueberauth.Strategy.Stripe.OAuth,
      client_id: System.get_env("STRIPE_CLIENT_ID"),
      client_secret: System.get_env("STRIPE_CLIENT_SECRET")
    ```

    Use that if you want to read client ID/secret from the environment
    variables in the run time:

    ```elixir
    config :ueberauth, Ueberauth.Strategy.Stripe.OAuth,
      client_id: {System, :get_env, ["STRIPE_CLIENT_ID"]},
      client_secret: {System, :get_env, ["STRIPE_CLIENT_SECRET"]}
    ```

1.  Include the Überauth plug in your controller:

    ```elixir
    defmodule MyApp.AuthController do
      use MyApp.Web, :controller
      plug Ueberauth
      ...
    end
    ```

1.  Create the request and callback routes if you haven't already:

    ```elixir
    scope "/auth", MyApp do
      pipe_through :browser

      get "/:provider", AuthController, :request
      get "/:provider/callback", AuthController, :callback
    end
    ```

1. Your controller needs to implement callbacks to deal with `Ueberauth.Auth` and `Ueberauth.Failure` responses.

For an example implementation see the [Überauth Example](https://github.com/ueberauth/ueberauth_example) application.

## Calling

Depending on the configured url you can initiate the request through:

    /auth/stripe
    
## License

Please see [LICENSE](https://github.com/svycal/ueberauth_stripe/blob/master/LICENSE) for licensing details.
