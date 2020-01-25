defmodule CIDR do
  defstruct [:class, :hosts, :last_address, :subnet_mask]

  alias CIDR.Calculator

  def parse(cidr_notation) when is_binary(cidr_notation) do
    with [a, b, c, cidr] <- String.split(cidr_notation, "."),
         [d, cidr] <- String.split(cidr, "/"),
         {int_a, _} <- Integer.parse(a),
         {int_b, _} <- Integer.parse(b),
         {int_c, _} <- Integer.parse(c),
         {int_d, _} <- Integer.parse(d),
         {int_cidr, _} <- Integer.parse(cidr) do
      last_address = last_address({int_a, int_b, int_c, int_d}, int_cidr)

      {
        :ok,
        %__MODULE__{
          class: Calculator.class(int_cidr),
          subnet_mask: subnet_mask(int_cidr),
          hosts: Calculator.no_of_hosts(int_cidr),
          last_address: last_address
        }
      }
    else
      _ ->
        {:error, :invalid}
    end
  end

  defp last_address({a, b, c, d}, cidr) do
    Calculator.last_address({a, b, c, d}, cidr)
    |> convert_to_string()
  end

  defp subnet_mask(cidr) do
    Calculator.subnet_mask(cidr) |> convert_to_string()
  end

  defp convert_to_string(<<a, b, c, d>>) do
    "#{a}.#{b}.#{c}.#{d}"
  end
end
