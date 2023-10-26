# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     LangChainDemo.Repo.insert!(%LangChainDemo.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

if Mix.env() == :dev do
  alias LangChainDemo.{FitnessUsers, FitnessUsersFixtures}
  alias LangChainDemo.FitnessUsers.FitnessUser

  defmodule Seeds.CreateNew do
    def find_or_create_fitness_user(id) do
      case FitnessUsers.get_fitness_user(id) do
        %FitnessUser{} = user ->
          user

        nil ->
          FitnessUsersFixtures.fitness_user_fixture()
      end
    end
  end

  Seeds.CreateNew.find_or_create_fitness_user(1)
end
