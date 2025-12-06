defmodule Day6 do
  def part1(input) do
    input
    |> String.split("\n")
    |> Enum.map(&String.split/1)
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&calculate/1)
    |> Enum.sum()
  end

  def part2(input) do
    lines = input |> String.split("\n")
    number_lines = Enum.slice(lines, 0..-2//1)
    ops_line = List.last(lines)

    numbers =
      number_lines
      |> Enum.map(&String.graphemes/1)
      |> Enum.zip()
      |> Enum.map(fn l ->
        l
        |> Tuple.to_list()
        |> Enum.join("")
        |> String.trim()
      end)
      |> Enum.chunk_by(fn x -> x |> String.trim() |> then(&(&1 == "")) end)
      |> Enum.reject(&(&1 == [""]))

    ops = String.split(ops_line)

    Enum.zip(numbers, ops)
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&List.flatten/1)
    |> Enum.map(&calculate/1)
    |> Enum.sum()
  end

  defp calculate(nums_and_op) do
    [op_str | nums_reversed_str] = Enum.reverse(nums_and_op)
    nums = nums_reversed_str |> Enum.reverse() |> Enum.map(&String.to_integer/1)
    op = parse_op(op_str)
    op.(nums)
  end

  defp parse_op("*"), do: &Enum.product/1
  defp parse_op("+"), do: &Enum.sum/1
end
