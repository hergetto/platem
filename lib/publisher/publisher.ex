defmodule Platem.Publisher do
  @moduledoc """
  This module is responsible for managing pages.
  """

  @doc """
  Saves a page to the file.
  """
  def save(page) do
    path = Path.join([Map.get(page, :folder), '#{Map.get(page, :name)}.html.heex'])
    File.write(path, page.html)

    page
    |> Map.put(:published, true)
    |> Map.put(:path, path)
  end

  @doc """
  Adds a page to the manager process.
  """
  def add_to_manager(page) do
    case Process.whereis(Platem.PageManager) do
      nil ->
        {:ok, pid} = Platem.start_manager()
        pid

      pid ->
        pid
    end
    |> GenServer.cast({:add_page, page})
  end

  @doc """
  Retrieves all the pages from the manager process.
  """
  def get_pages do
    case Process.whereis(Platem.PageManager) do
      nil ->
        {:ok, _pid} = Platem.start_manager()
        []

      pid ->
        pid |> Platem.PageManager.get_state()
    end
  end
end
