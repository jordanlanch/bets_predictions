defmodule ScrappingBet.Scrapper.Scrapper do

  alias ScrappingBet.Predictions

  def get_smoothies_url() do
    case HTTPoison.get("http://143.89.16.84:9090/") do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        urls =
          body
          |> convert_map()
          |> insert_is_exists()

        {:ok, urls}

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts("Not found :(")

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
    end
  end

  def convert_map(body) do
    body
    |> Floki.find("tr.accordion-toggle")
    |> Enum.map(fn {"tr", _, tds} ->
      data = Enum.map(tds, fn {"td", [], [data]} -> data end)

      Enum.zip(
        [
          :sports,
          :match_title,
          :league,
          :result_to_bet,
          :date_game,
          :time_game,
          :best_bookie,
          :best_odds,
          :mean_median
        ],
        data
      )
      |> Map.new()
    end)
  end

  def insert_is_exists(bets) do
    Enum.map(bets, fn bet -> Predictions.fetch_or_create_bets(bet) end)

  end
end
