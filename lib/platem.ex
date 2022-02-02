defmodule Platem do
  @moduledoc """
  This module provides a simple interface to the Platem.
  This module is also the main supervisor and it should be included in the main supervision tree.
  """

  use DynamicSupervisor
  alias Platem.Populator

  @doc false
  def start_link(_args) do
    DynamicSupervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  @doc false
  def start_populator(template, values) do
    spec = {Populator, {template, values}}
    DynamicSupervisor.start_child(__MODULE__, spec)
  end


  @doc """
  Populates a template with the given values.

  # Example
      iex> Populator.populate(%Template{template: "{{name}}", fields: [%Field{name: "name", default: "default"}]}, clause: {"{{", "}}"}, [%Value{name: "name", value: "value"}])
      %Template{template: "value", fields: [%Field{name: "name", default: "name"}]}
  """
  def populate(template, values) do
    case start_populator(template, values) do
      {:ok, pid} ->
        pid |> GenServer.call(:populate)
      {:error, reason} ->
        raise reason
    end
  end

  @impl true
  def init(_args) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end
end
