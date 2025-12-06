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
    grid = to_grid(input)
    space_columns = find_space_columns(grid)
    num_starts = [0] ++ Enum.map(space_columns, fn x -> x + 1 end)
    num_ends = Enum.map(space_columns, fn x -> x - 1 end) ++ [grid[:size_x] - 1]
    number_ranges = Enum.zip(num_starts, num_ends)

    number_ranges
    |> Enum.map(&read_numbers_and_ops_from_columns(&1, grid))
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

  defp to_grid(input) do
    lines = String.split(input, "\n")
    size_y = length(lines)
    size_x = String.length(List.first(lines))

    cells =
      for {line, y} <- Enum.with_index(lines),
          {elem, x} <- Enum.with_index(String.graphemes(line)),
          into: %{} do
        {{x, y}, elem}
      end

    %{
      cells: cells,
      size_x: size_x,
      size_y: size_y
    }
  end

  defp find_space_columns(grid) do
    %{cells: cells, size_x: size_x, size_y: size_y} = grid

    all_spaces? = fn col_number ->
      0..(size_y - 1)
      |> Enum.map(&cells[{col_number, &1}])
      |> Enum.all?(&(&1 == " "))
    end

    0..(size_x - 1)
    |> Enum.filter(all_spaces?)
  end

  defp read_numbers_and_ops_from_columns(range, grid) do
    %{cells: cells, size_y: size_y} = grid
    {from, to} = range

    numbers_str = to..from//-1 |> Enum.map(&read_column_number(&1, grid))

    op_str =
      from..to
      |> Enum.map(&cells[{&1, size_y - 1}])
      |> Enum.join("")
      |> String.trim()

    numbers_str ++ [op_str]
  end

  defp read_column_number(col, grid) do
    %{cells: cells, size_y: size_y} = grid

    0..(size_y - 2)
    |> Enum.map(&cells[{col, &1}])
    |> Enum.join("")
    |> String.trim()
  end
end
