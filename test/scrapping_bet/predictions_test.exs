defmodule ScrappingBet.PredictionsTest do
  use ScrappingBet.DataCase

  alias ScrappingBet.Predictions

  describe "results" do
    alias ScrappingBet.Predictions.Bets

    @valid_attrs %{best_bookie: "some best_bookie", best_odds: 120.5, date_game: ~N[2010-04-17 14:00:00], league: "some league", match_title: "some match_title", mean_median: "some mean_median", result_to_bet: "some result_to_bet", sports: "some sports", time_game: ~T[14:00:00]}
    @update_attrs %{best_bookie: "some updated best_bookie", best_odds: 456.7, date_game: ~N[2011-05-18 15:01:01], league: "some updated league", match_title: "some updated match_title", mean_median: "some updated mean_median", result_to_bet: "some updated result_to_bet", sports: "some updated sports", time_game: ~T[15:01:01]}
    @invalid_attrs %{best_bookie: nil, best_odds: nil, date_game: nil, league: nil, match_title: nil, mean_median: nil, result_to_bet: nil, sports: nil, time_game: nil}

    def bets_fixture(attrs \\ %{}) do
      {:ok, bets} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Predictions.create_bets()

      bets
    end

    test "list_results/0 returns all results" do
      bets = bets_fixture()
      assert Predictions.list_results() == [bets]
    end

    test "get_bets!/1 returns the bets with given id" do
      bets = bets_fixture()
      assert Predictions.get_bets!(bets.id) == bets
    end

    test "create_bets/1 with valid data creates a bets" do
      assert {:ok, %Bets{} = bets} = Predictions.create_bets(@valid_attrs)
      assert bets.best_bookie == "some best_bookie"
      assert bets.best_odds == 120.5
      assert bets.date_game == ~N[2010-04-17 14:00:00]
      assert bets.league == "some league"
      assert bets.match_title == "some match_title"
      assert bets.mean_median == "some mean_median"
      assert bets.result_to_bet == "some result_to_bet"
      assert bets.sports == "some sports"
      assert bets.time_game == ~T[14:00:00]
    end

    test "create_bets/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Predictions.create_bets(@invalid_attrs)
    end

    test "update_bets/2 with valid data updates the bets" do
      bets = bets_fixture()
      assert {:ok, %Bets{} = bets} = Predictions.update_bets(bets, @update_attrs)
      assert bets.best_bookie == "some updated best_bookie"
      assert bets.best_odds == 456.7
      assert bets.date_game == ~N[2011-05-18 15:01:01]
      assert bets.league == "some updated league"
      assert bets.match_title == "some updated match_title"
      assert bets.mean_median == "some updated mean_median"
      assert bets.result_to_bet == "some updated result_to_bet"
      assert bets.sports == "some updated sports"
      assert bets.time_game == ~T[15:01:01]
    end

    test "update_bets/2 with invalid data returns error changeset" do
      bets = bets_fixture()
      assert {:error, %Ecto.Changeset{}} = Predictions.update_bets(bets, @invalid_attrs)
      assert bets == Predictions.get_bets!(bets.id)
    end

    test "delete_bets/1 deletes the bets" do
      bets = bets_fixture()
      assert {:ok, %Bets{}} = Predictions.delete_bets(bets)
      assert_raise Ecto.NoResultsError, fn -> Predictions.get_bets!(bets.id) end
    end

    test "change_bets/1 returns a bets changeset" do
      bets = bets_fixture()
      assert %Ecto.Changeset{} = Predictions.change_bets(bets)
    end
  end
end
