# Platem

Platem is a templating engine made for Elixir.

## Installation

Platem can be installed by adding it to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:platem, "~> 0.2.0"}
  ]
end
```

After you have added platem to your mix file, and you have installed it, you have to paste the following code snippet into your supervision tree:

```elixir
{DynamicSupervisor, name: Platem, strategy: :one_for_one}
```

After you have done that you are good to go.

## Usage

To use platem, you have to define a template first. You can do it in the following way:

```elixir
template = %Platem.Template{
  template: "some {{type}}",
  fields: [
    %Platem.Field{name: "type", default: "markdown"}
  ]
  clause: {"{{", "}}"}
}
```

After we have done that we can define the values.
If a value is left blank, the engine will use the default value.

```elixir
values = [
  %Platem.Value{name: "type", value: "html"}
]
```

Finally we can call the populate function.

```elixir
Platem.populate(template, values)
```

Which will give us the following:

```elixir
%Platem.Template{
  template: "some html",
  fields: [
    %Platem.Field{name: "type", default: "markdown"}
  ]
  clause: {"{{", "}}"}
}
```

The docs can be found at <https://hexdocs.pm/platem>.
