defmodule PageTest do
  use ExUnit.Case
  alias Platem.Page

  test "set folder when folder is nil" do
    page = %Page{}
    folder = "test"
    ret = Page.set_folder(page, folder)
    assert ret.folder == folder
  end

  test "set folder when folder is not nil" do
    page = %Page{folder: "kaas"}
    folder = "test"
    ret = Page.set_folder(page, folder)
    assert ret.folder == folder
  end
end
