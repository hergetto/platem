defmodule PopulatorTest do
  use ExUnit.Case

  def default_template, do: template({"{{", "}}"})

  def template(clause) do
    %Platem.Template{
      template: "{{title}}<%=title%>",
      fields: [
        %Platem.Field{:name => "title", :default => "Platem Example!"}
      ],
      clause: clause
    }
  end

  def values do
    [
      %Platem.Value{name: "title", value: "Platem Example"}
    ]
  end

  def empty_values do
    [
      %Platem.Value{name: "title"}
    ]
  end

  test "populates a template with mustache clause" do
    template = default_template()
    values = values()

    {:ok, pid} = Platem.Populator.start_link({template, values})
    ret = GenServer.call(pid, :populate)
    assert ret.template == "Platem Example<%=title%>"
  end

  test "use default values" do
    template = default_template()
    values = empty_values()

    {:ok, pid} = Platem.Populator.start_link({template, values})
    ret = GenServer.call(pid, :populate)
    assert ret.template == "Platem Example!<%=title%>"
  end

  test "populate a template with other clause" do
    template = template({"<%=", "%>"})
    values = values()

    {:ok, pid} = Platem.Populator.start_link({template, values})
    ret = GenServer.call(pid, :populate)
    assert ret.template == "{{title}}Platem Example"
  end
end
