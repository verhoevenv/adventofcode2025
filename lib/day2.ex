defmodule Day2 do
  def part1(input) do
    input
    |> String.split(",")
    |> Enum.map(fn line -> String.split(line, "-") |> Enum.map(&String.to_integer/1) end)
    |> Enum.flat_map(&find_invalid_ids/1)
    |> Enum.sum()
  end

  def part2(_input) do
    :todo
  end

  defp find_invalid_ids([from, to]) do
    from..to
    |> Stream.filter(&is_repeated_sequence/1)
  end

  defp is_repeated_sequence(number) do
    number
    |> Integer.to_string()
    |> then(fn s -> String.split_at(s, div(String.length(s), 2)) end)
    |> then(fn {first_half, second_half} -> first_half == second_half end)
  end

end
