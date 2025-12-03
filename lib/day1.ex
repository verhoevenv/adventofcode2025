defmodule Day1 do
  def part1(input) do
    start_position = 50

    String.split(input, "\n")
    |> Enum.map(&dir_to_num/1)
    |> Enum.scan(start_position, &rotate/2)
    |> Enum.filter(&(&1 == 0))
    |> Enum.count()
  end

  def part2(input) do
    start_position = 50

    {_position, zeros} =
      String.split(input, "\n")
      |> Enum.map(&dir_to_num/1)
      |> Enum.reduce({start_position, 0}, &rotate_and_count/2)

    zeros
  end

  defp dir_to_num(<<?R, tail::binary>>) do
    String.to_integer(tail)
  end

  defp dir_to_num(<<?L, tail::binary>>) do
    -String.to_integer(tail)
  end

  defp rotate(rotation, current) do
    Integer.mod(current + rotation, 100)
  end

  defp rotate_and_count(0, {current_position, current_zeros}) do
    {current_position, current_zeros}
  end

  defp rotate_and_count(rotation, {current_position, current_zeros}) do
    {new_rotation, new_position} =
      cond do
        rotation > 0 -> {rotation - 1, Integer.mod(current_position + 1, 100)}
        rotation < 0 -> {rotation + 1, Integer.mod(current_position - 1, 100)}
      end

    new_zeros = current_zeros + if new_position == 0, do: 1, else: 0
    rotate_and_count(new_rotation, {new_position, new_zeros})
  end
end
