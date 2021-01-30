defmodule ScrappingBet.Predictions.Bets do
  use Ecto.Schema
  import Ecto.Changeset

  schema "results" do
    field :best_bookie, :string
    field :best_odds, :float
    field :date_game, :naive_datetime
    field :league, :string
    field :match_title, :string
    field :mean_median, :string
    field :result_to_bet, :string
    field :sports, :string
    field :time_game, :time

    timestamps()
  end

  @doc false
  def changeset(bets, attrs) do
    bets
    |> cast(attrs, [:sports, :match_title, :league, :result_to_bet, :date_game, :time_game, :best_bookie, :best_odds, :mean_median])
    |> validate_required([:sports, :match_title, :league, :result_to_bet, :date_game, :time_game, :best_bookie, :best_odds, :mean_median])
  end
end
