defmodule Day1 do
  def part1(input) do
    start_position = 50

    String.split(input, "\n")
    |> Enum.map(&dir_to_num/1)
    |> Enum.scan(start_position, &rotate/2)
    |> Enum.filter(&(&1 == 0))
    |> Enum.count()
  end

  defp dir_to_num(<<?R, tail::binary>>) do
    String.to_integer(tail)
  end

  defp dir_to_num(<<?L, tail::binary>>) do
    -String.to_integer(tail)
  end

  defp rotate(current, rotation) do
    Integer.mod(current + rotation, 100)
  end
end
