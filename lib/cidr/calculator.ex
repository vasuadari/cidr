defmodule CIDR.Calculator do
  @total_network_bits 32

  alias CIDR.Math

  def class(cidr) do
    subnet_mask(cidr)
    |> case do
      <<_, 0, 0, 0>> ->
        :A

      <<_, _, 0, 0>> ->
        :B

      <<_, _, _, _>> ->
        :C
    end
  end

  def subnet_mask(@total_network_bits), do: <<255, 255, 255, 255>>

  def subnet_mask(cidr) do
    {a, left_over} = assign_octet(cidr)
    {b, left_over} = assign_octet(left_over)
    {c, left_over} = assign_octet(left_over)
    {d, _left_over} = assign_octet(left_over)

    a <> b <> c <> d
  end

  defp assign_octet(0) do
    {<<0>>, 0}
  end

  defp assign_octet(cidr) when cidr < 8 do
    octet = 255 - (Math.pow(2, 8 - cidr) - 1)
    {<<octet>>, 0}
  end

  defp assign_octet(cidr) do
    {<<255>>, cidr - 8}
  end

  def no_of_hosts(@total_network_bits), do: 1

  def no_of_hosts(cidr) when is_integer(cidr) do
    host_bits = @total_network_bits - cidr

    Math.pow(2, host_bits)
  end

  def last_address(cidr) do
    <<a, b, c, d>> = subnet_mask(cidr)

    <<255 - a, 255 - b, 255 - c, 255 - d>>
  end

  def last_address({a, b, c, d}, @total_network_bits) do
    <<a, b, c, d>>
  end

  def last_address({a, b, c, d}, cidr) do
    <<l_a, l_b, l_c, l_d>> = last_address(cidr)
    a = min(255, a + l_a)
    b = min(255, b + l_b)
    c = min(255, c + l_c)
    d = min(255, d + l_d)

    <<a, b, c, d>>
  end
end
