defmodule Platem.Publisher do
  def save(page) do
    path = Path.join([Map.get(page, :folder), '#{Map.get(page, :name)}.html.heex'])
    File.write(path, page.html)

    page
    |> Map.put(:published, true)
    |> Map.put(:path, path)
  end

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
