defmodule ScrappingBet.Repo do
  use Ecto.Repo,
    otp_app: :scrapping_bet,
    adapter: Ecto.Adapters.Postgres
end
