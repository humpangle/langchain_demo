defmodule LangChainDemo.Repo.Migrations.CreateFitnessUsers do
  use Ecto.Migration

  def change do
    create table(:fitness_users) do
      add :name, :string, null: false
      add :gender, :string
      add :age, :integer
      add :why, :string
      add :fitness_experience, :string
      add :goals, :string
      add :resources, :string
      add :overall_fitness_plan, :string
      add :fitness_plan_for_week, :string
      add :limitations, :string
      add :notes, :string
      add :timezone, :string

      timestamps()
    end
  end
end
