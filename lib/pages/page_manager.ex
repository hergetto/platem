defmodule Platem.PageManager do
  use GenServer

  def start_link(state) do
    GenServer.start(__MODULE__, state, name: __MODULE__)
  end

  def get_state(pid) do
    pid |> GenServer.call(:get_state)
  end

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_cast({:add_page, page}, state) do
    {:noreply, [page | state]}
  end

  @impl true
  def handle_call(:get_state, _from, state) do
    {:reply, state, state}
  end
end
