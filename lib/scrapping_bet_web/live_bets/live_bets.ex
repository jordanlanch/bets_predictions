defmodule ScrappingBetWeb.LiveBets do
  # If you generated an app with mix phx.new --live,
  # the line below would be: use MyAppWeb, :live_view
  use Phoenix.LiveView

  alias ScrappingBet.Predictions

  def render(assigns) do
    ~L"""

    <div style="display: flex; margin-bottom: 20px;">
      <div >
        <h2>Efficacy</h2>
        <div style="color: green"><%=@efficacy%></div>
      </div>
      <div style="margin-left: 60px">
        <h2>Game Predictions</h2>
        <div><%=@get_finished_results%></div>
      </div>
      <div style="margin-left: 60px">
        <h2>Win Predictions</h2>
        <div><%=@get_worked_results%></div>
      </div>
    </div>

    <h1>Listing Predictions</h1>

    <table>
    <thead>
    <tr>
      <th>Sports</th>
      <th>Match title</th>
      <th>League</th>
      <th>Result to bet</th>
      <th>Date game</th>
      <th>Best bookie</th>
      <th>Best odds</th>
      <th>Mean median</th>
      <th>Is Finish</th>
      <th>Final Result</th>
      <th>is Works</th>

      <th></th>
    </tr>
    </thead>
    <tbody>
    <%= for bets <- @results do %>
    <tr>
      <td><%= bets.sports %></td>
      <td><%= bets.match_title %></td>
      <td><%= bets.league %></td>
      <td><%= bets.result_to_bet %></td>
      <td><%= bets.date_game %></td>
      <td><%= bets.best_bookie %></td>
      <td><%= bets.best_odds %></td>
      <td><%= bets.mean_median %></td>
      <td><%= bets.is_finish %></td>
      <td><%= bets.final_result %></td>
      <td><%= bets.is_work %></td>
    </tr>
    <% end %>
    </tbody>
    </table>

    """
  end

  def mount(_params, _, socket) do
    if connected?(socket), do: :timer.send_interval(30000, self(), :update)

    get_worked_results = Predictions.get_worked_results()
    get_finished_results = Predictions.get_finished_results()

    efficacy =Float.round(((get_worked_results / get_finished_results) * 100), 2)

    results = Predictions.list_results()

    {:ok,
     assign(socket,
       results: results,
       get_worked_results: get_worked_results,
       get_finished_results: get_finished_results,
       efficacy: efficacy
     )}
  end

  def handle_info(:update, socket) do
    get_worked_results = Predictions.get_worked_results()
    get_finished_results = Predictions.get_finished_results()

    efficacy =Float.round(((get_worked_results / get_finished_results) * 100), 2)

    results = Predictions.list_results()

    {:noreply,
     assign(socket,
       results: results,
       get_worked_results: get_worked_results,
       get_finished_results: get_finished_results,
       efficacy: efficacy
     )}
  end
end
