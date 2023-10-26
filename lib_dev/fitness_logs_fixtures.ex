defmodule LangChainDemo.FitnessLogsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LangChainDemo.FitnessLogs` context.
  """

  def valid_fitness_log_attrs(caller_attrs \\ %{})

  def valid_fitness_log_attrs(caller_attrs) when is_list(caller_attrs),
    do: Map.new(caller_attrs) |> valid_fitness_log_attrs()

  def valid_fitness_log_attrs(caller_attrs) do
    defaults = %{
      activity: "some activity",
      amount: 42,
      date: ~D[2023-10-06],
      units: "some units"
    }

    Enum.into(caller_attrs, defaults)
  end

  @doc """
  Generate a fitness_log.
  """
  def fitness_log_fixture(user_id, caller_attrs \\ %{}) do
    values = valid_fitness_log_attrs(caller_attrs)

    {:ok, fitness_log} = LangChainDemo.FitnessLogs.create_fitness_log(user_id, values)

    fitness_log
  end
end
