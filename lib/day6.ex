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

  def part2(_input) do
    "todo"
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
