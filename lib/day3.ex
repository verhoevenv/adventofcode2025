defmodule Day3 do
  def part1(input) do
    String.split(input, "\n")
    |> Enum.map(&String.to_charlist/1)
    |> Enum.map(&max_joltage(&1, 2))
    |> Enum.sum()
  end

  def part2(input) do
    String.split(input, "\n")
    |> Enum.map(&String.to_charlist/1)
    |> Enum.map(&max_joltage(&1, 12))
    |> Enum.sum()
  end

  defp max_joltage(bank, number) do
    digits = max_joltage2(bank, number)
    List.to_integer(digits)
  end

  defp max_joltage2(_, 0), do: []

  defp max_joltage2(bank, number) do
    without_last = Enum.slice(bank, 0..(length(bank) - number))
    first_digit = Enum.max(without_last)
    remaining = bank |> Enum.drop_while(fn x -> x !== first_digit end) |> Enum.drop(1)
    other_digits = max_joltage2(remaining, number - 1)
    [first_digit | other_digits]
  end
end
