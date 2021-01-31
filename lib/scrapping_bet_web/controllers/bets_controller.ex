defmodule ScrappingBetWeb.BetsController do
  use ScrappingBetWeb, :controller

  alias ScrappingBet.Predictions
  alias ScrappingBet.Predictions.Bets

  def index(conn, _params) do
    results = Predictions.list_results()
    
    render(conn, "index.html", results: results)
  end

  def new(conn, _params) do
    changeset = Predictions.change_bets(%Bets{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"bets" => bets_params}) do
    case Predictions.create_bets(bets_params) do
      {:ok, bets} ->
        conn
        |> put_flash(:info, "Bets created successfully.")
        |> redirect(to: Routes.bets_path(conn, :show, bets))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    bets = Predictions.get_bets!(id)
    render(conn, "show.html", bets: bets)
  end

  def edit(conn, %{"id" => id}) do
    bets = Predictions.get_bets!(id)
    changeset = Predictions.change_bets(bets)
    render(conn, "edit.html", bets: bets, changeset: changeset)
  end

  def update(conn, %{"id" => id, "bets" => bets_params}) do
    bets = Predictions.get_bets!(id)

    case Predictions.update_bets(bets, bets_params) do
      {:ok, bets} ->
        conn
        |> put_flash(:info, "Bets updated successfully.")
        |> redirect(to: Routes.bets_path(conn, :show, bets))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", bets: bets, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    bets = Predictions.get_bets!(id)
    {:ok, _bets} = Predictions.delete_bets(bets)

    conn
    |> put_flash(:info, "Bets deleted successfully.")
    |> redirect(to: Routes.bets_path(conn, :index))
  end
end
