defmodule ScrappingBet.Predictions do
  @moduledoc """
  The Predictions context.
  """

  import Ecto.Query, warn: false
  alias ScrappingBet.Repo

  alias ScrappingBet.Predictions.Bets

  @doc """
  Returns the list of results.

  ## Examples

      iex> list_results()
      [%Bets{}, ...]

  """
  def list_results do
    Repo.all(Bets)
  end

  @doc """
  Gets a single bets.

  Raises `Ecto.NoResultsError` if the Bets does not exist.

  ## Examples

      iex> get_bets!(123)
      %Bets{}

      iex> get_bets!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bets!(id), do: Repo.get!(Bets, id)

  @doc """
  Creates a bets.

  ## Examples

      iex> create_bets(%{field: value})
      {:ok, %Bets{}}

      iex> create_bets(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bets(attrs \\ %{}) do
    %Bets{}
    |> Bets.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a bets.

  ## Examples

      iex> update_bets(bets, %{field: new_value})
      {:ok, %Bets{}}

      iex> update_bets(bets, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bets(%Bets{} = bets, attrs) do
    bets
    |> Bets.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a bets.

  ## Examples

      iex> delete_bets(bets)
      {:ok, %Bets{}}

      iex> delete_bets(bets)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bets(%Bets{} = bets) do
    Repo.delete(bets)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bets changes.

  ## Examples

      iex> change_bets(bets)
      %Ecto.Changeset{data: %Bets{}}

  """
  def change_bets(%Bets{} = bets, attrs \\ %{}) do
    Bets.changeset(bets, attrs)
  end

  @spec exists_bet?(keyword) :: boolean()
  def exists_bet?(%{league: league, match_title: match_title, result_to_bet: result_to_bet, date_game: date_game}) do
    from(b in Bets,
     where: b.league == ^league,
     where: b.result_to_bet == ^result_to_bet,
     where: b.date_game == ^date_game,
     where: b.match_title == ^match_title
     )
    |> Repo.exists?()
  end

  @spec fetch_or_create_bets(map) :: {:ok, Bets.t()}
  def fetch_or_create_bets(attrs) do
    with false <- exists_bet?(attrs),
         {:ok, thing} <- create_bets(attrs) do
      {:ok, thing}
    else
      true ->
        {:ok, "has already been taken"}
    end
  end


  def get_finished_results do
    from(b in Bets, where: b.is_finish == true, select: count()
     )
    |> Repo.one()
  end

  def get_worked_results do
    from(b in Bets, where: b.is_work == true, select: count()
     )
    |> Repo.one()
  end


end
