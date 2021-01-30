defmodule ScrappingBet.Repo.Migrations.CreateResults do
  use Ecto.Migration

  def change do
    create table(:results) do
      add :sports, :string
      add :match_title, :string
      add :league, :string
      add :result_to_bet, :string
      add :date_game, :naive_datetime
      add :time_game, :time
      add :best_bookie, :string
      add :best_odds, :float
      add :mean_median, :string

      timestamps()
    end

  end
end
