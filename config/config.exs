use Mix.Config

config :ueberauth, Ueberauth,
  providers: [
    stripe:
      {Ueberauth.Strategy.Stripe,
       [
         oauth2_module: OAuthMock
       ]}
  ]
