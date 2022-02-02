defmodule Platem.Populator do
  @moduledoc """
  This module is a GenServer responsible for populating a template.
  """

  use GenServer
  alias Platem.Template
  alias Platem.Value
  alias Platem.Field

  @doc false
  def start_link(state) do
    GenServer.start_link(__MODULE__, state)
  end

  @doc """
  Find a field with the same name.

  # Examples
      iex> Platem.Populator.find_field("name", [%Platem.Field{name: "name", default: "default"}])
      %Platem.Field{name: "name", default: "default"}
  """
  def find_field(name, []), do: name
  def find_field(name, [%Field{name: field_name} = field | tail]) do
    cond do
      field_name == name ->
       field
      true ->
        find_field(name, tail)
    end
  end

  @doc """
  Populates a template with the given values.

  # Example
      iex> Platem.Populator.populate(%Platem.Template{template: "{{name}}", fields: [%Platem.Field{name: "name", default: "default"}], clause: {"{{", "}}"}}, [%Platem.Value{name: "name", value: "value"}])
      %Platem.Template{template: "value", fields: [%Platem.Field{name: "name", default: "name"}]}
  """
  def populate(%Template{} = template, []), do: template
  def populate(%Template{template: template_string, fields: fields, clause: {open, close}} = template, [%Value{name: name, value: value} | tail]) do
     replace = case value do
      nil ->
        %Field{default: default} = find_field(name, fields)
        default
      _ ->
        value
    end
    template |> Map.put(:template, String.replace(template_string, "#{open}#{name}#{close}", replace)) |> populate(tail)
  end

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_call(:populate, _from, {template, values} = state) do
    {:reply, populate(template, values), state}
  end
end
