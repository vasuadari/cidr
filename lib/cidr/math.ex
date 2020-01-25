defmodule CIDR.Math do
  def pow(x, y) do
    :math.pow(x, y)
    |> Float.to_string()
    |> Integer.parse()
    |> case do
      {int, _} ->
        int

      _ ->
        :error
    end
  end
end
