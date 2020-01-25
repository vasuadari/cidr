defmodule CIDR.CLI do
  def main([cidr_notation]) do
    CIDR.parse(cidr_notation)
    |> case do
      {:ok, %CIDR{} = cidr} ->
        IO.puts "#{cidr_notation}"
        IO.puts "Class: #{cidr.class}"
        IO.puts "Subnet Mask: #{cidr.subnet_mask}"
        IO.puts "No. of hosts: #{cidr.hosts}"
        IO.puts "Last Address: #{cidr.last_address}"

      {:error, :invalid} ->
        IO.puts "#{cidr_notation} is invalid"
    end
  end

  def main([]) do
    IO.puts "Usage: cidr [IPv4_ADDRESS]/[CIDR]"
  end
end
