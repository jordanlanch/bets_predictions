defmodule ScrappingBetWeb.BetsControllerTest do
  use ScrappingBetWeb.ConnCase

  alias ScrappingBet.Predictions

  @create_attrs %{best_bookie: "some best_bookie", best_odds: 120.5, date_game: ~N[2010-04-17 14:00:00], league: "some league", match_title: "some match_title", mean_median: "some mean_median", result_to_bet: "some result_to_bet", sports: "some sports", time_game: ~T[14:00:00]}
  @update_attrs %{best_bookie: "some updated best_bookie", best_odds: 456.7, date_game: ~N[2011-05-18 15:01:01], league: "some updated league", match_title: "some updated match_title", mean_median: "some updated mean_median", result_to_bet: "some updated result_to_bet", sports: "some updated sports", time_game: ~T[15:01:01]}
  @invalid_attrs %{best_bookie: nil, best_odds: nil, date_game: nil, league: nil, match_title: nil, mean_median: nil, result_to_bet: nil, sports: nil, time_game: nil}

  def fixture(:bets) do
    {:ok, bets} = Predictions.create_bets(@create_attrs)
    bets
  end

  describe "index" do
    test "lists all results", %{conn: conn} do
      conn = get(conn, Routes.bets_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Results"
    end
  end

  describe "new bets" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.bets_path(conn, :new))
      assert html_response(conn, 200) =~ "New Bets"
    end
  end

  describe "create bets" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.bets_path(conn, :create), bets: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.bets_path(conn, :show, id)

      conn = get(conn, Routes.bets_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Bets"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.bets_path(conn, :create), bets: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Bets"
    end
  end

  describe "edit bets" do
    setup [:create_bets]

    test "renders form for editing chosen bets", %{conn: conn, bets: bets} do
      conn = get(conn, Routes.bets_path(conn, :edit, bets))
      assert html_response(conn, 200) =~ "Edit Bets"
    end
  end

  describe "update bets" do
    setup [:create_bets]

    test "redirects when data is valid", %{conn: conn, bets: bets} do
      conn = put(conn, Routes.bets_path(conn, :update, bets), bets: @update_attrs)
      assert redirected_to(conn) == Routes.bets_path(conn, :show, bets)

      conn = get(conn, Routes.bets_path(conn, :show, bets))
      assert html_response(conn, 200) =~ "some updated best_bookie"
    end

    test "renders errors when data is invalid", %{conn: conn, bets: bets} do
      conn = put(conn, Routes.bets_path(conn, :update, bets), bets: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Bets"
    end
  end

  describe "delete bets" do
    setup [:create_bets]

    test "deletes chosen bets", %{conn: conn, bets: bets} do
      conn = delete(conn, Routes.bets_path(conn, :delete, bets))
      assert redirected_to(conn) == Routes.bets_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.bets_path(conn, :show, bets))
      end
    end
  end

  defp create_bets(_) do
    bets = fixture(:bets)
    %{bets: bets}
  end
end
