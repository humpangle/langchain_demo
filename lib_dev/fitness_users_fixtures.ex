defmodule LangChainDemo.FitnessUsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LangChainDemo.FitnessUsers` context.
  """

  def valid_fitness_user_attrs(attrs \\ %{})

  def valid_fitness_user_attrs(attrs) when is_list(attrs),
    do: Map.new(attrs) |> valid_fitness_user_attrs()

  def valid_fitness_user_attrs(attrs) do
    seq = Sequence.seeded("fitness_user_fixture", 1)

    defaults = %{
      age: seq,
      overall_fitness_plan: nil,
      fitness_experience: :beginner,
      gender: "male",
      goals: "goal #{seq}",
      name: "name #{seq}",
      resources: "resource #{seq}",
      why: "why #{seq}",
      timezone: "America/Toronto"
    }

    Enum.into(attrs, defaults)
  end

  @doc """
  Generate a fitness_user.
  """
  def fitness_user_fixture(attrs \\ %{}) do
    {:ok, fitness_user} =
      attrs
      |> valid_fitness_user_attrs()
      |> LangChainDemo.FitnessUsers.create_fitness_user()

    fitness_user
  end
end
