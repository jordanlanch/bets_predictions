defmodule ScrappingBet.Repo.Migrations.AddFinalResults do
  use Ecto.Migration

  def change do
    alter table(:results) do
      add :is_finish, :bool, default: false
      add :final_result, :string
      add :is_work, :bool, default: false
    end
  end
end
