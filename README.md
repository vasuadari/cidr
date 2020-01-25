# CIDR
![](https://github.com/vasuadari/cidr/workflows/Elixir%20CI/badge.svg)

A simple package to calculate subnet mask, number of hosts, last address
and class of CIDR from a given CIDR notation.

## Installation

The package can be installed by adding `cidr` to your list of dependencies
in `mix.exs`:

```elixir
def deps do
  [
    {:cidr, github: "vasuadari/cidr"}
  ]
end
```

## Usage

```elixir
iex(1)> CIDR.parse("10.1.0.0/16")
{:ok,
 %CIDR{
   class: :B,
   hosts: 65536,
   last_address: "10.1.255.255",
   subnet_mask: "255.255.0.0"
 }}
```
