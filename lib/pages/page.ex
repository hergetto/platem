defmodule Platem.Page do
  defstruct [:html, :folder, :name, :published, :path]

  def save_page(page) do
    File.write(
      Path.join([Map.get(page, :folder), '#{Map.get(page, :name)}.html.heex']),
      page.html
    )
  end
end
